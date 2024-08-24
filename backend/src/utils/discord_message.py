"""
This module contains Discord Message models.
"""

import os
import traceback

from discord_webhook import DiscordEmbed, DiscordWebhook
from utils import constants


def error_message(exc: Exception):
    """
    This functions send error message.
    """
    if constants.ENVIRONMENT != "prod":
        return

    discord_webhook = DiscordWebhook(os.environ["DISCORD_WEBHOOK_URL"])

    embed = DiscordEmbed(title=":x: An Error Occurred :x:", color="FF0000")
    embed.add_embed_field(name="Error Message", value=str(exc), inline=False)
    embed.add_embed_field(
        name="Traceback",
        value=f"```python\n{traceback.format_exc()}\n```",
        inline=False,
    )

    discord_webhook.add_embed(embed)
    response = discord_webhook.execute()
