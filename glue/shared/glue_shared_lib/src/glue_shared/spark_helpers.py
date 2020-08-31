"""Useful functions to simplify Spark functionality."""
import logging

LOGGER = logging.getLogger(__name__)


def read_parquet(spark, path):
    """Read the data from a raw zone bucket."""
    LOGGER.info("Reading parquet data from %s", path)
    df = spark.read.parquet(path)
    LOGGER.debug("DF: %s", show_spark_df(df, 10))
    return df


def show_spark_df(df, n=20, truncate=True, vertical=False):
    """
    Show DataFrame as str, useful for logging.

    Notes
    -----
    Reimplemented from:
    https://spark.apache.org/docs/2.4.5/api/python/_modules/pyspark/sql/dataframe.html#DataFrame.show
    """
    if isinstance(truncate, bool) and truncate:
        return df._jdf.showString(n, 20, vertical)
    else:
        return df._jdf.showString(n, int(truncate), vertical)
