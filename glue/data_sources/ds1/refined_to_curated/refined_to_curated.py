"""
AWS GLUE PySpark Job to process REFINED data.
From Refined zone to Curated zone.
"""
import datetime
import logging

import pyspark
from glue_shared import get_spark_session_and_glue_job
from glue_shared.spark_helpers import read_parquet

LOGGER = logging.getLogger("job")


def run_etl(cfg, spark: pyspark.sql.SQLContext):
    df = read_parquet(spark, f"s3://{cfg['S3_BUCKET']}/{cfg['s3_prefix']}")
    LOGGER.debug("Count in: %s", df.count())
    LOGGER.debug("Here we can continue processing data and write them to the curated zone.")


def main():
    spark, job = get_spark_session_and_glue_job(JOB_CONFIG)
    LOGGER.debug("Spark job started at: %s", datetime.datetime.utcnow().isoformat())

    run_etl(JOB_CONFIG, spark)

    LOGGER.debug("Spark job finished at: %s", datetime.datetime.utcnow().isoformat())


if __name__ == "__main__":
    from config import JOB_CONFIG

    main()
