"""
This module contains utility function to handle datetime
"""

from datetime import datetime, timezone


def utc_now() -> datetime:
    """
    This method returns UTC now.
    """
    return datetime.now(timezone.utc)


def to_string_date(date: datetime) -> str:
    """
    This method converts datetime to string date.
    """
    return date.strftime("%Y-%m-%d")
