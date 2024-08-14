"""
This module contains Assertion class.
"""

import json

from rich.console import Console

from utils import constants


class LocalisationAssertion:
    """
    This class asserts Google Sheet.
    """

    def __init__(self, console: Console, game: str):
        self.game = game
        self.__console = console
        self.__columns = set()
        self.__checked_keys = set()
        self.__missing_keys = set()

        with open("fr.json", encoding="utf-8") as f:
            self.__localisation = set(json.load(f))

    def check(self, column: str, value: str):
        """
        This method checks column and value keys.
        """
        self.__columns.add(column)

        column_key = f"{self.game}.{column}"
        self.__checked_keys.add(column_key)
        if column_key not in self.__localisation:
            self.__missing_keys.add(column_key)
        if column in constants.COLUMNS_NOT_TO_ASSERT[self.game]:

            return

        value_key = f"{column_key}.{value}"
        self.__checked_keys.add(value_key)
        if value_key not in self.__localisation:
            self.__missing_keys.add(value_key)

    def log_errors(self):
        """
        This method logs errors.
        """
        not_checked_keys = self.__localisation - self.__checked_keys
        # Handle ONLY extra keys linked with backend data
        extra_keys = set()
        for not_checked_key in not_checked_keys:
            for column in self.__columns:
                if not_checked_key.startswith(f"{self.  game}.{column}"):
                    extra_keys.add(not_checked_key)

        if not self.__missing_keys and not extra_keys:
            self.__console.log("[bold green]The localisation file is synced!")
            return

        if self.__missing_keys:
            self.__console.log("[bold red]MISSING KEYS")
            for missing_key in sorted(self.__missing_keys):
                self.__console.log(f"[bold red]  • {missing_key}")

        if extra_keys:
            self.__console.log("[bold dark_orange]EXTRA KEYS")
            for extra_key in sorted(extra_keys):
                self.__console.log(f"[bold dark_orange]  • {extra_key}")
