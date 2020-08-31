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

    LOGGER.info("Reading raw data from %s", JOB_CONFIG["dataset_url"])
    df = pd.read_csv(JOB_CONFIG["dataset_url"], sep=";")
    print(df.shape)
    write_parquet(df, f"s3://{JOB_CONFIG['s3_bucket']}/{JOB_CONFIG['s3_prefix']}")


if __name__ == "__main__":
    from config import JOB_CONFIG

    main()
