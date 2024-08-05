"""
This module contains util functions.
"""

from datetime import datetime, timezone
import json
from typing import Any


def decode_from_redis(data: dict[str, Any]) -> dict[str, Any]:
    """
    This function decodes strings from redis item.
    """
    decoded_data = {}
    for key, value in data.items():
        try:
            decoded_data[key] = json.loads(value)
        except json.decoder.JSONDecodeError:
            decoded_data[key] = value

    return decoded_data


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
