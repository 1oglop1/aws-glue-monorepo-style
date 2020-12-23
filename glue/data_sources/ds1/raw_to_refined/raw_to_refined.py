"""
AWS GLUE PyShell Job to process RAW data.
From Raw zone to Refined zone.
"""
import logging
import pandas as pd
from glue_shared.pandas_helpers import write_parquet

LOGGER = logging.getLogger("job")


def main():
    LOGGER.info("JOB_NAME: %s", JOB_CONFIG["JOB_NAME"])
    LOGGER.info("JOB_ID: %s", JOB_CONFIG["JOB_ID"])
    LOGGER.info("JOB_RUN_ID %s", JOB_CONFIG["JOB_RUN_ID"])

    LOGGER.info("WORKFLOW_NAME: %s", JOB_CONFIG["WORKFLOW_NAME"])
    LOGGER.info("WORKFLOW_RUN_ID %s", JOB_CONFIG["WORKFLOW_RUN_ID"])
    data_src = f"s3://{JOB_CONFIG['S3_BUCKET']}/{JOB_CONFIG['s3_raw_prefix']}/cereal.csv"
    LOGGER.info("Reading raw data from %s", data_src)
    df = pd.read_csv(data_src, sep=";")
    LOGGER.info("DF shape %s", df.shape)
    write_parquet(df, f"s3://{JOB_CONFIG['S3_BUCKET']}/{JOB_CONFIG['s3_refined_prefix']}")


if __name__ == "__main__":
    from config import JOB_CONFIG

    main()
