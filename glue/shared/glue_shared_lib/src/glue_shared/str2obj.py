import datetime
import logging
from typing import Tuple

import dateutil.parser

LOGGER = logging.getLogger(__name__)


def str2bool(value):
    return value.lower() == "true"


def comma_str_time_2_time_obj(comma_str: str) -> Tuple[datetime.datetime, ...]:
    """
    Convert comma separated time strings into a list of datetime objects.

    Parameters
    ----------
    comma_str
        Comma separated times: 2020-04-20 16:00:00, 2020-04-20 15:00:00

    Returns
    -------
        A list of datetime objects.
    """

    return tuple(dateutil.parser.parse(time_str) for time_str in comma_str.split(","))
