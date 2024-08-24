"""
This module contains util functions for user interaction.
"""

from pick import pick
from rich.console import Console

from utils import constants


def ask_environment(console: Console) -> str:
    """
    This function asks and returns environment.
    """
    environment, _ = pick(options=constants.ENVIRONMENTS, title="Select environment")
    console.log(f"[bold magenta]We are in [green]{environment} [magenta]environment")
    return str(environment)


def ask_game(console: Console) -> str:
    """
    This function asks and returns game.
    """
    game, _ = pick(options=constants.GAMES, title="Select game")
    console.log(f"[bold magenta]Working on [green]{game} [magenta]game")
    return str(game)
