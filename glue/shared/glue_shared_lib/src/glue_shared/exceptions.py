"""Exceptions specific to glue_shared library."""


class GlueJobError(Exception):
    """Base glue error."""


class ParametersNotFound(GlueJobError):
    """SSM parameters not found."""


class DataNotAvailable(GlueJobError):
    """Data not available."""


class JobFailedError(GlueJobError):
    """It looks like SystemExit is caught by glue, hence this is needed."""


class IllegalArgumentError(ValueError):
    """Illegal arguments supplied."""
