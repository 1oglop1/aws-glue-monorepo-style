"""Argument handles for Glue jobs until AWS unifies the interface."""
import argparse
import logging
from typing import Sequence, List, Dict

LOGGER = logging.getLogger(__name__)


class ArgumentError(Exception):
    pass


class CustomArgumentParser(argparse.ArgumentParser):
    def error(self, msg):
        raise ArgumentError(msg)


def parse_args_fallback(arguments: Sequence, options: List[str] = None) -> Dict:
    """
    Argument parser fallback for AWS Glue jobs.

    This Fallback function is necessary due to lack of API uniformity
    between PySpark and PyShell jobs.

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
    LOGGER.debug("Parsing arguments with fallback function.")
    LOGGER.debug("Parsing arguments: %s options: %s", arguments, options)
    parser = CustomArgumentParser()
    if not options:
        options = []
    for opt in options:
        parser.add_argument(f"--{opt}", required=True)

    args = vars(parser.parse_known_args(arguments[1:])[0])
    return args


def parse_args(arguments: Sequence, options: List[str] = None) -> Dict:
    """
    Parse input arguments.

    Simple assessment that module AWS Glue is not available in pyshell jobs.

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
    LOGGER.debug("Parsing arguments: %s options: %s", arguments, options)

    try:
        import awsglue.utils as au
    except ImportError:
        return parse_args_fallback(arguments, options)

    try:
        resolved = au.getResolvedOptions(args=arguments, options=options)
        LOGGER.debug("awsglue.utils args resolved: %s", resolved)
        return resolved
    except au.GlueArgumentError:
        return parse_args_fallback(arguments, options)
