"""
This module contains main endpoints of default services.
"""

from datetime import datetime

from flask import jsonify

import tasks
from config import app, redis
from utils.date import to_string_date, get_now
from utils.redis_decode import decode_from_redis


@app.get("/config/<game>")
def get_game_config(game: str):
    """
    This endpoint returns game config.
    """
    # Fetch characters
    keys = redis.keys(f"{game}:character:*")
    characters = [decode_from_redis(redis.hgetall(key)) for key in keys]  # type: ignore

    # Fetch modes
    keys = redis.keys(f"{game}:mode:*")
    modes = [decode_from_redis(redis.hgetall(key)) for key in keys]  # type: ignore
    modes.sort(key=lambda m: m["order"])
    return jsonify(characters=characters, modes=[mode["id"] for mode in modes])


@app.get("/config/<game>/<mode>")
def get_mode_config(game: str, mode: str):
    """
    This endpoint returns mode config.
    """
    today_date = get_now()
    today = to_string_date(today_date)

    # Fetch config
    config = decode_from_redis(redis.hgetall(f"{game}:mode:{mode}"))  # type: ignore

    # Fetch target
    today_target = decode_from_redis(
        redis.hgetall(f"history:{today}:{game}:{mode}")  # type: ignore
    )
    assert today_target, "Missing History Item!"

    return jsonify(
        config=config,
        target=decode_from_redis(
            redis.hgetall(f"{game}:character:{today_target['target']}")  # type: ignore
        ),
        timestamp=int(
            datetime(
                year=today_date.year, month=today_date.month, day=today_date.day
            ).timestamp()
        ),
    )


@app.post("/debug")
def debug():
    """debug"""
    tasks.schedule_levels()
