"""
This module contains functions to decode Redis data.
"""

import contextlib
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
