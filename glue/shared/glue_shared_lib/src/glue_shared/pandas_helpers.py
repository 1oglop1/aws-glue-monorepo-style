import logging
from typing import List

import pandas as pd
from glue_shared.boto3_helpers import get_s3_keys

LOGGER = logging.getLogger(__name__)


def write_parquet(
    df: pd.DataFrame,
    s3_folder_url: str,
    partition_cols: List[str] = None,
    compression: str = None,
):
    """
    Write Parquet file to S3 folder.

    Parameters
    ----------
    df
        Pandas dataframe
    s3_folder_url
        S3 url: s3://<bucket>/<prefix>.
    partition_cols
        Partition path by columns
    compression
        Parquet compression. Default is "snappy"

    """

    import pyarrow as pa
    import pyarrow.parquet as pq
    import s3fs

    LOGGER.info("Writing parquet file to S3: %s", f"{s3_folder_url}")
    table = pa.Table.from_pandas(df, preserve_index=False)

    pq.write_to_dataset(
        table,
        s3_folder_url,
        filesystem=s3fs.S3FileSystem(),
        partition_cols=partition_cols,
        compression=compression or "snappy",
    )


def df_from_s3_json(
    s3_client,
    bucket_name: str,
    prefix: str,
    compression: str = None,
    lines: bool = True,
):
    """
    Create Pandas DataFrame from multiple files in S3 prefix.

    Parameters
    ----------
    s3_client
        boto3.client('s3')
    bucket_name
    prefix
    compression
        Json file compression.
    lines
        Multiple JSON objects per line.

    Returns
    -------
    pd.DataFrame
        Dataframe containing data under S3 prefix.

    """

    df_merged = pd.DataFrame()

    for key in get_s3_keys(s3_client, bucket_name, prefix):
        resp = s3_client.get_object(Bucket=bucket_name, Key=key)
        df = pd.read_json(
            resp["Body"], orient="records", lines=lines, compression=compression
        )
        df_merged = df_merged.append(df, ignore_index=True)

    return df_merged
