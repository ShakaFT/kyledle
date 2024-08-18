"""
This module contains main endpoints of default services.
"""

from flask import jsonify

from config import app, redis
from utils import decode_from_redis, to_string_date, utc_now


@app.get("/")
def hello():
    """hello"""
    return "Hello World"


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
    modes = [key.split(":")[-1] for key in keys]  # type: ignore
    return jsonify(characters=characters, modes=modes)


@app.get("/config/<game>/<mode>")
def get_mode_config(game: str, mode: str):
    """
    This endpoint returns mode config.
    """
    today = to_string_date(utc_now())

    # Fetch config
    config = decode_from_redis(redis.hgetall(f"{game}:mode:{mode}"))  # type: ignore

    # Fetch target
    today_target = decode_from_redis(
        redis.hgetall(f"history:{today}:{game}:{mode}")  # type: ignore
    )
    assert today_target, "Missing History Item!"

    return jsonify(config=config, target=today_target["target"])
