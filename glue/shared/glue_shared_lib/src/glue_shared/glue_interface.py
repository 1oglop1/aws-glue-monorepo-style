"""A collection of functions to interface with AWS GLUE."""
import logging
from typing import List, Dict, Sequence, Iterable

LOGGER = logging.getLogger(__name__)


def get_glue_args(arguments: Sequence, options: List[str] = None) -> Dict:
    """
    Parse Arguments supplied to the Job.

    Parameters
    ----------
    arguments
        Sequence of options and values to be parsed. (sys.argv)
    options
        Options which value is resolved.

    Returns
    -------
        Parsed options and values.

    """
    LOGGER.debug("Parsing arguments for PySpark job")
    from awsglue.utils import getResolvedOptions

    LOGGER.debug("Parsing arguments: %s options: %s", arguments, options)
    if not options:
        return getResolvedOptions(args=arguments, options=["JOB_NAME"])
    return getResolvedOptions(arguments, options=["JOB_NAME"] + options)


def get_spark_session_and_glue_job(
    glue_args: Dict,
    conf=None,
    py_files: Iterable[str] = None,
    extra_jars: List[str] = None,
):
    """
    Get spark session and AWS glue job.

    Parameters
    ----------
    glue_args
        Dictionary of Argument Name: Argument value
    extra_jars
        Path to dependent jar files
    conf : Union[pyspark.SparkConf, Dict[str, str]]
        Spark config, either object or dictionary of config options.
    py_files
        Paths to python files (.py, .zip, .egg)

    Returns
    -------
    pyspark.sql.SparkSession, awsglue.job.Job

    """
    from awsglue.context import GlueContext
    from awsglue.job import Job
    from pyspark import SparkContext, SparkConf

    LOGGER.debug("Creating spark session with parameters")
    LOGGER.debug("conf=%s", conf)
    LOGGER.debug("py_files=%s", py_files)
    LOGGER.debug("extra_jars=%s", extra_jars)
    if isinstance(conf, dict):
        spark_conf = SparkConf()
        spark_conf.setAll(conf.items())
    elif isinstance(conf, SparkConf):
        spark_conf = conf
    else:
        spark_conf = None

    if extra_jars and spark_conf:
        spark_dependencies = ",".join(extra_jars)
        spark_conf.set("spark.jars.packages", spark_dependencies)

    sc = SparkContext.getOrCreate(conf=spark_conf)

    if py_files:
        LOGGER.debug("Adding PYFILEs: %s", py_files)
        for py_file in py_files:
            sc.addPyFile(py_file)

    glue_context = GlueContext(sparkContext=sc)
    job = Job(glue_context=glue_context)
    job.init(glue_args["JOB_NAME"], glue_args)

    # .py, .zip or .egg
    return glue_context.spark_session, job


def commit_job(job):
    """Commit AWS glue job."""
    job.commit()
