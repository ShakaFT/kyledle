"""
This module contains constants.
"""

import os

FRONTEND_PATH = os.environ["FRONTEND_PATH"]

ENVIRONMENTS = ["local", "dev", "prod"]
GAMES = ["mhdle"]

GOOGLE_SHEET_URL = "https://docs.google.com/spreadsheets/d/1nwVxOynl2rduEWoAVuZjmrlnlDiHwu3RUUoleJ-j6uo/export?format=csv"
GOOGLE_SHEET_ID = {"mhdle": "644384787"}

COLUMNS_NOT_TO_ASSERT = {"mhdle": ["average-size", "picture", "is-subspecies"]}
COLUMNS_WITH_MULTIPLE_VALUES = {
    "mhdle": ["ailments", "colors", "elements", "weaknesses"]
}
COLUMNS_WITH_PICTURE = {"mhdle": ["ailments", "elements", "weaknesses"]}
