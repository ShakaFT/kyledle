"""
This module contains utility function to handle datetime
"""

from datetime import datetime


def get_now() -> datetime:
    """
    This method returns now in local time.
    """
    return datetime.now()


def to_string_date(date: datetime) -> str:
    """
    This method converts datetime to string date.
    """
    return date.strftime("%Y-%m-%d")
