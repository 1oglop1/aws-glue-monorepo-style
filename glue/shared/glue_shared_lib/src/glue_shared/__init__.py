"""Collection of convenient functions shared among the glue jobs."""

import logging

from glue_shared.argument_handlers import parse_args
from glue_shared.boto3_helpers import (
    resolve_ssm_parameters,
    get_connection,
    gracefully_exit,
)
from glue_shared.glue_interface import (
    get_glue_args,
    get_spark_session_and_glue_job,
    commit_job,
)
from glue_shared.str2obj import str2bool, comma_str_time_2_time_obj

LOGGER = logging.getLogger("glue_shared")
LOGGER.addHandler(logging.NullHandler())

__all__ = [
    "parse_args",
    "resolve_ssm_parameters",
    "get_connection",
    "gracefully_exit",
    "get_glue_args",
    "get_spark_session_and_glue_job",
    "commit_job",
    "str2bool",
    "comma_str_time_2_time_obj",
]
