"""
This script allows to upload data.
"""

import json
from typing import Any, Iterable

from google.cloud import storage
import pandas as pd
from redis import Redis
from rich.console import Console

from utils import constants, interaction


console = Console()
redis = Redis(host="localhost", port=6379, decode_responses=True)
storage_client = storage.Client()

public_bucket = storage_client.bucket("kyledle-public")

ENVIRONMENT = interaction.ask_environment(console)
GAME = interaction.ask_game(console)


def remove_data(characters: Iterable[str]):
    """
    This function removes data.
    """
    for character in characters:
        redis.delete(f"{GAME}:character:{character}")


def upload_data(characters: dict[str, Any]):
    """
    This function uploads data to database.
    """
    for character, character_data in characters.items():
        redis.hset(f"{GAME}:character:{character}", mapping=character_data)

    redis.hset(
        f"{GAME}:mode:classic",
        mapping={
            "columns": json.dumps(
                [
                    "character",
                    "picture",
                    "monster_type",
                    "elements",
                    "weaknesses",
                    "ailments",
                    "generation",
                    "subspecies",
                ]
            ),
            "indices": json.dumps(["average_size", "colors"]),
        },
    )


def main():
    """
    main function
    """
    console.log("[bold magenta]Will fetch characters from Google Sheet...")
    characters = {}
    df = pd.read_csv(
        f"{constants.GOOGLE_SHEET_URL}&gid={constants.GOOGLE_SHEET_ID[GAME]}"
    )
    for _, row in df.iterrows():
        character = row["Character"].strip()
        blob = public_bucket.blob(f"{GAME}/{character}.png")

        character_data = {}
        for column in df.columns:
            value = row[column]
            column = column.replace(" ", "-").lower()

            if column == "picture":
                value = blob.public_url
            elif isinstance(value, bool):
                value = "true" if value is True else "false"
            elif isinstance(value, str) and column[-1] == "s":
                value = json.dumps([element.strip() for element in value.split("/")])

            character_data[column] = value

        characters[character] = character_data

    console.log("[bold magenta]Will fetch characters from database...")
    csv_characters = set(characters)
    db_characters = set(key.split(":")[-1] for key in redis.keys(f"{GAME}:character:*"))  # type: ignore
    new_characters = csv_characters - db_characters
    removed_characters = db_characters - csv_characters

    if new_characters:
        console.log("[bold blue]These characters will be added")
        for new_character in new_characters:
            console.log(f"[bold green] • {new_character}")

    if removed_characters:
        console.log("[bold blue]These characters will be removed")
        for removed_character in removed_characters:
            console.log(f"[bold green] • {removed_character}")

    console.log("[bold magenta]Will upload data...")
    upload_data(characters)
    remove_data(removed_characters)
    console.log("[bold green]Upload completed!")


if __name__ == "__main__":
    main()
