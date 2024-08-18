"""
This module contains tasks.
"""

from collections import defaultdict
from datetime import timedelta
import random

from celery import shared_task
from config import redis
from utils import decode_from_redis, to_string_date, utc_now


@shared_task
def hello_world():
    """hello_world"""
    print("Hello World")


@shared_task
def schedule_levels():
    """
    This endpoint schedules levels.
    """
    now = utc_now()
    tomorrow = to_string_date(now + timedelta(days=1))

    if redis.keys(f"history:{tomorrow}:*"):
        raise ValueError(f"{tomorrow} already scheduled!")

    already_scheduled_characters = defaultdict(lambda: defaultdict(list))
    for i in range(5):
        formatted_date = to_string_date(now - timedelta(days=i))
        for key in redis.keys(f"history:{formatted_date}:*"):  # type: ignore
            _, _, game, mode = key.split(":")
            item = decode_from_redis(redis.hgetall(key))  # type: ignore
            already_scheduled_characters[game][mode].append(item["target"])

    for key in redis.keys("*:mode:*"):  # type: ignore
        game, _, mode = key.split(":")

        characters = []
        for character_key in redis.keys(f"{game}:character:*"):  # type: ignore
            character = character_key.split(":")[-1]
            if character not in already_scheduled_characters[game][mode]:
                characters.append(character)

        redis.hset(
            f"history:{tomorrow}:{game}:{mode}",
            mapping={"target": random.choice(characters)},
        )
