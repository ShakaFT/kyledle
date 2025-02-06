"""
This module contains utility function to handle datetime
"""

from datetime import datetime

import pytz

from utils import constants


def get_now() -> datetime:
    """
    This method returns now in local time.
    """
    return datetime.now(pytz.timezone(constants.TIMEZONE))


def to_string_date(date: datetime) -> str:
    """
    This method converts datetime to string date.
    """
    return date.strftime("%Y-%m-%d")
