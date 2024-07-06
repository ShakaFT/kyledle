"""
This module contains HistoryItem class.
"""

from datetime import datetime
from typing import Any

import pytz

from restAPI.FlaskApp import current_app

import constants


class HistoryItem:
    """
    This class represents History Item.
    """

    __DATE_FORMAT = "%Y-%m-%d"
    __DATE_TZ = pytz.timezone("Europe/Paris")

    def __init__(self, date: datetime, data: dict[str, Any]):
        self.__date = date
        self.__data = data

    @classmethod
    def from_database(cls, date: datetime):
        """
        This method creates an instance of HistoryItem from database.
        """
        if data := current_app.database.get(
            constants.COLLECTION_HISTORY, cls.__convert_datetime(date)
        ):
            return cls(date, data)

    def target(self, game: str, mode: str) -> str:
        """
        This method returns target.
        """
        return self.__data[game][mode]

    def to_dict(self) -> dict[str, Any]:
        """
        This method returns dict containing History Item.
        """
        return self.__data

    def update_database(self):
        """
        This method updates History Item in database.
        """
        current_app.database.update(
            constants.COLLECTION_HISTORY,
            self.__convert_datetime(self.__date),
            self.__data,
        )

    @staticmethod
    def __convert_datetime(date: datetime) -> str:
        return (
            date.replace(tzinfo=pytz.utc)
            .astimezone(HistoryItem.__DATE_TZ)
            .strftime(HistoryItem.__DATE_FORMAT)
        )
