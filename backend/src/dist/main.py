"""
This module contains main endpoints of default services.
"""

import json
import os

from firebase_admin import storage
from flask import jsonify, request

from restAPI.FlaskApp import FlaskApp


app = FlaskApp(
    "default",
    os.environ["GOOGLE_CLOUD_PROJECT"],
    allowed_origins=["https://kyledle.web.app"],
)
app.api_key(os.environ["KYLEDLE_API_KEY_HEADER"], os.environ["KYLEDLE_API_KEY"])


@app.get("/data")
def get_data():
    """
    This endpoints returns data.
    """
    args = dict(request.args)
    try:
        mode = args["mode"]
        game = args["game"]
    except KeyError as e:
        return jsonify(error=f"missing {str(e)}"), 400

    bucket = storage.bucket(f"{os.environ['GOOGLE_CLOUD_PROJECT']}.appspot.com")
    blob = bucket.get_blob(f"{game}_{mode}.json")
    return jsonify(json.loads(blob.download_as_string()))  # type: ignore


if __name__ == "__main__":
    app.run(host="localhost", port=8080, debug=True)
