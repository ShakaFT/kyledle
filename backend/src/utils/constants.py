"""
This module contains constants.
"""

import os

ENVIRONMENT = os.environ["ENVIRONMENT"]
IS_GUNICORN = "gunicorn" in os.environ.get("SERVER_SOFTWARE", "")
