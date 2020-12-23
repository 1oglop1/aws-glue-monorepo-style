"""This module intends to provide base configuration for AWS Glue jobs."""
import logging
from typing import Dict


class InfoDebugFilter(logging.Filter):
    def filter(self, rec):
        """Filter debug and info messages."""
        return rec.levelno in (logging.DEBUG, logging.INFO)


def default_logging_config(level: str = "INFO", formatter_name: str = "detailed") -> Dict:
    """
    Create default logging config.

    Parameters
    ----------
    level
        Log level.
    formatter_name
        Log formatter name. Possible values: detailed or dev.

    Returns
    -------
        Dictionary compatible with logging.config.dictConfig.

    """
    logging_config = {
        "version": 1,
        "filters": {"info_debug_filter": {"()": InfoDebugFilter}},
        "formatters": {
            "detailed": {
                "class": "logging.Formatter",
                "format": "%(asctime)s %(levelname)-8s %(name)-15s - %(message)s",
            },
            "dev": {
                "class": "logging.Formatter",
                "format": "%(asctime)s %(levelname)s %(name)s - ++++++++ %(message)s ++++++++",
            },
        },
        "handlers": {
            "debug_handler": {
                "class": "logging.StreamHandler",
                "formatter": formatter_name,
                "level": "DEBUG",
                "filters": ["info_debug_filter"],
                "stream": "ext://sys.stdout",
            },
            "warning": {
                "class": "logging.StreamHandler",
                "formatter": formatter_name,
                "level": "WARNING",
                "stream": "ext://sys.stdout",
            },
        },
        "loggers": {
            "job": {
                "level": level,
                "propagate": False,
                "handlers": ["debug_handler", "warning"],
            },
            "glue_shared": {
                "level": level,
                "propagate": False,
                "handlers": ["debug_handler", "warning"],
            },
        },
        "root": {"level": "WARNING", "handlers": ["debug_handler", "warning"]},
    }

    return logging_config
