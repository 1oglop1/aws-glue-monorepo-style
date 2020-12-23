"""
Configuration file for ds1-raw-to-refined Python Shell Glue job.
"""

import logging.config
import sys

from glue_shared import parse_args
from glue_shared.defaults import default_logging_config

arguments = parse_args(sys.argv, ["APP_SETTINGS_ENVIRONMENT", "LOG_LEVEL", "S3_BUCKET"])

LOGGING_CONFIG = default_logging_config(arguments["LOG_LEVEL"])
logging.config.dictConfig(LOGGING_CONFIG)

JOB_CONFIG = dict(arguments)
# must be hard-coded because glue does not provide this in PyShell jobs
JOB_CONFIG["JOB_NAME"] = JOB_CONFIG.get("JOB_NAME") or "ds1-raw-to-refined"
JOB_CONFIG["JOB_ID"] = JOB_CONFIG.get("JOB_ID")
JOB_CONFIG["JOB_RUN_ID"] = JOB_CONFIG.get("JOB_RUN_ID")

JOB_CONFIG["WORKFLOW_NAME"] = JOB_CONFIG.get("WORKFLOW_NAME")
JOB_CONFIG["WORKFLOW_RUN_ID"] = JOB_CONFIG.get("WORKFLOW_RUN_ID")

# raw data

JOB_CONFIG["s3_raw_prefix"] = "ds1/raw"
JOB_CONFIG["s3_refined_prefix"] = "ds1/refined"
