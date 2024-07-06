"""
This module contains Kyledle Data
"""

import json
from typing import Any

from firebase_admin import storage

import constants


class KyledleData:
    """
    This class represents Kyledle data.
    """

    def __init__(self, data: dict[str, Any]):
        self.__data = data

    @classmethod
    def from_database(cls, game: str, mode: str):
        """
        This method creates an instance from database.
        """
        bucket = storage.bucket(constants.KYLEDLE_BUCKET_NAME)
        blob_name = f"{game}/{mode}.json"
        blob = bucket.get_blob(blob_name)

        if not blob:
            raise ValueError(f"{blob_name} NOT found")

        return cls(json.loads(blob.download_as_string()))

    @property
    def characters(self) -> dict[str, Any]:
        """
        This method returns characters.
        """
        return self.__data["characters"]

    def to_dict(self) -> dict[str, Any]:
        """
        This method returns dict contains Kyledle data.
        """
        return self.__data
