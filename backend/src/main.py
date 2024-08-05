"""
This module contains main endpoints of default services.
"""

from collections import defaultdict
from datetime import timedelta
import random

from flask import jsonify

from config import app, redis
from utils import decode_from_redis, to_string_date, utc_now


# app = FlaskApp(
#     "default",
#     os.environ["GOOGLE_CLOUD_PROJECT"],
#     allowed_origins=["https://kyledle.web.app"],
#     allowed_headers=[os.environ["KYLEDLE_API_KEY_HEADER"]],
# )
# app.api_key(os.environ["KYLEDLE_API_KEY_HEADER"], os.environ["KYLEDLE_API_KEY"])


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
    keys = redis.keys(f"{game}:monster:*")
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
    today_target = decode_from_redis(redis.hgetall(f"history:{today}:{game}:{mode}"))  # type: ignore
    assert today_target, "Missing History Item!"

    return jsonify(config=config, target=today_target["target"])


@app.post("/schedule")
def schedule():
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

    return jsonify(), 204


if __name__ == "__main__":
    app.run(host="localhost", port=8080, debug=True)
