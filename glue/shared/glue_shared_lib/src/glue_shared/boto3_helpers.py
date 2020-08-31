"""Convenient methods requiring boto3 client."""
import json
import logging
from typing import Dict
from urllib.parse import urlsplit

from glue_shared.exceptions import ParametersNotFound, JobFailedError, DataNotAvailable
from glue_shared.helpers import chunked

LOGGER = logging.getLogger(__name__)


def resolve_ssm_parameters(ssm_client, parameters: Dict) -> Dict:
    """
    Resolve multiple SSM parameters from a dict.

    Parameters
    ----------
    ssm_client
        boto3.client('ssm')
    parameters
        A dictionary of friendly names and parameter names.

    Examples
    --------
    >>> import boto3
    ... resolve_ssm_parameters(boto3.client('ssm'), {"db_host": "/dev/db/HOST"})
    {'db_host': 'value'}

    Returns
    -------
    dict
        The original dict with resolved values instead of ssm paths.

    """
    tmp = {value: key for key, value in parameters.items()}

    valid_parameters = []
    invalid_parameters = []

    for chunk in chunked(tuple(tmp.keys()), 10):
        response = ssm_client.get_parameters(Names=chunk, WithDecryption=True)
        valid_parameters.extend(response["Parameters"])
        invalid_parameters.extend(response["InvalidParameters"])

    if invalid_parameters:
        raise ParametersNotFound("Unable to get parameters.", *invalid_parameters)

    tmp.update({param["Name"]: param["Value"] for param in valid_parameters})

    return {key: tmp[value] for key, value in parameters.items()}


def get_connection(glue_client, name: str) -> Dict:
    """
    Get connection properties.

    Parameters
    ----------
    glue_client
        boto3.client('glue')
    name
        A connection name.

    Examples
    --------
    >>> import boto3
    ... get_connection(boto3.client('glue'), "connection-name"})
    {
    'NAME': '<string>',
    'TYPE': '<string>'
    'JDBC_CONNECTION_URL': '<string>'
    'PASSSWORD': '<string>',
    'USERNAME': '<string>,
    }

    Returns
    -------
        A dictionary of connection properties.
        Mapping of the dictionary is a simplified version of
        boto3 response.
        {
        'NAME': 'Name',
        'TYPE': 'ConnectionType'
        ... then follows ConnectionProperties
        'JDBC_CONNECTION_URL': '<string>'
        'PASSSWORD': '<string>',
        'USERNAME': '<string>,
        ...if jdbc
        'HOST': '<string>',
        'PORT': '<string>',
        'DATABASE': '<string>',
        }

    """
    response = glue_client.get_connection(Name=name)

    ret = {
        "NAME": response["Connection"]["Name"],
        "TYPE": response["Connection"]["ConnectionType"],
        **response["Connection"]["ConnectionProperties"],
    }

    if response["Connection"]["ConnectionType"] == "JDBC":
        surl = urlsplit(
            response["Connection"]["ConnectionProperties"][
                "JDBC_CONNECTION_URL"
            ].lstrip("jdbc:")
        )

        ret.update(
            {
                "HOST": surl.hostname,
                "PORT": surl.port,
                "DATABASE": surl.path.lstrip("/"),
            }
        )

    return ret


def gracefully_exit(
    sns_client,
    sns_topic_arn,
    process_results: Dict,
    job_result: str = "PASS",
    message: str = "Job failed.",
):
    """
    Update workflow status SSM parameter and exit with error if job failed.

    Parameters
    ----------
    sns_client
        boto3.client('sns')
    sns_topic_arn
        Workflow notification topic ARN.
    process_results
        A dictionary containing the results of the processing.
        This dict must contain json serialisable object.
    job_result
        Job result FAIL or PASS.  # is not validated here.
    message
        Exit message if job fails.

    """
    LOGGER.debug("Sending SNS message")
    LOGGER.debug("Process results: %s", process_results)
    sns_client.publish(TopicArn=sns_topic_arn, Message=json.dumps(process_results))
    if job_result == "FAIL":
        LOGGER.debug("Exiting with message. %s", message)
        raise JobFailedError(message)


def get_s3_keys(client, bucket_name: str, prefix: str):
    """
    Get keys from S3 bucket by prefix
    Parameters
    ----------
    client
        boto3.client('s3')
    bucket_name
    prefix

    Yields
    -------
        list_objects_v2 Response

    """
    paginator = client.get_paginator("list_objects_v2")
    response_iterator = paginator.paginate(Bucket=bucket_name, Prefix=prefix)
    LOGGER.info("Reading S3: s3://%s/%s", bucket_name, prefix)
    for idx, page in enumerate(response_iterator):
        try:
            for response in page["Contents"]:
                yield response["Key"]
        except KeyError:
            raise DataNotAvailable(f"No data available at: s3://{bucket_name}/{prefix}")
