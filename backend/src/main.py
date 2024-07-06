"""
This module contains main endpoints of default services.
"""

from datetime import datetime, timedelta
import os
import random

from flask import jsonify, request

from restAPI.FlaskApp import FlaskApp

from models.History import HistoryItem
from models.KyledleData import KyledleData


app = FlaskApp(
    "default",
    os.environ["GOOGLE_CLOUD_PROJECT"],
    allowed_origins=["https://kyledle.web.app"],
    allowed_headers=[os.environ["KYLEDLE_API_KEY_HEADER"]],
)
app.api_key(os.environ["KYLEDLE_API_KEY_HEADER"], os.environ["KYLEDLE_API_KEY"])


@app.get("/data")
def get_data():
    """
    This endpoints returns data.
    """
    args = dict(request.args)
    try:
        game = args["game"]
        mode = args["mode"]
    except KeyError as e:
        return jsonify(error=f"Invalid args: missing {e}"), 400

    data = KyledleData.from_database(game, mode)
    item = HistoryItem.from_database(datetime.now())
    assert item, "Missing History Item!"

    return jsonify(data=data.to_dict(), target=item.target(game, mode))


@app.post("/schedule")
def schedule():
    """
    This endpoint schedules levels.
    """
    now = datetime.now()
    tomorrow = now + timedelta(days=1)

    if HistoryItem.from_database(tomorrow):
        raise ValueError(f"{tomorrow} already scheduled!")

    game = "mhdle"
    mode = "classic"

    kyledle_data = KyledleData.from_database(game, mode)

    already_scheduled_characters = []
    for i in range(5):
        if item := HistoryItem.from_database(now - timedelta(days=i)):
            already_scheduled_characters.append(item.target(game, mode))

    characters = [
        character
        for character in kyledle_data.characters
        if character not in already_scheduled_characters
    ]

    history_item = HistoryItem(tomorrow, {game: {mode: random.choice(characters)}})
    history_item.update_database()
    return jsonify(), 204


if __name__ == "__main__":
    app.run(host="localhost", port=8080, debug=True)
