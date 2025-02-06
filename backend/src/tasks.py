"""
This module contains tasks.
"""

import random
from collections import defaultdict
from datetime import timedelta

from config import redis
from utils.celery_task import celery_task
from utils.date import to_string_date, get_now
from utils.redis_decode import decode_from_redis


@celery_task
def schedule_levels(tomorrow=True):
    """
    This endpoint schedules levels.
    """
    now = get_now()
    date_to_schedule = to_string_date(now + timedelta(days=1) if tomorrow else now)

    if redis.keys(f"history:{date_to_schedule}:*"):
        return

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
            f"history:{date_to_schedule}:{game}:{mode}",
            mapping={"target": random.choice(characters)},
        )
