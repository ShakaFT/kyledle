"""
This module checks localisation files.
"""

import json

from dotenv import load_dotenv
from rich.console import Console

from models.Assertion import LocalisationAssertion
from utils import constants, db, interaction

load_dotenv()

console = Console()
ENVIRONMENT = interaction.ask_environment(console)

redis = db.get_db(ENVIRONMENT)


def check_database(assertion: LocalisationAssertion):
    """
    This function checks localisation file from database.
    """
    for key in redis.keys(f"{assertion.game}:character:*"):  # type: ignore
        character_data = redis.hgetall(key)
        for key, value in character_data.items():  # type: ignore
            try:
                for decoded_value in json.loads(value):
                    assertion.check(key, decoded_value)
            except (json.decoder.JSONDecodeError, TypeError):
                assertion.check(key, value)


def main():
    """
    main function
    """
    for game in constants.GAMES:
        console.log(f"[bold magenta]Will assert [green]{game} [magenta]game")
        assertion = LocalisationAssertion(console, game=game)
        check_database(assertion)

        assertion.log_errors()


if __name__ == "__main__":
    main()
