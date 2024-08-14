"""
This module contains util functions.
"""

import contextlib
from datetime import datetime, timezone
import json
from typing import Any


def decode_from_redis(data: dict[str, Any]) -> dict[str, Any]:
    """
    This function decodes strings from redis item.
    """
    decoded_data = {}
    for key, value in data.items():
        decoded_data[key] = value
        match value:
            case "true":
                decoded_data[key] = True
            case "false":
                decoded_data[key] = False

        with contextlib.suppress(json.decoder.JSONDecodeError):
            decoded_data[key] = json.loads(value)

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
