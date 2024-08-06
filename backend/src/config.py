"""
This module allowed to create app.
"""

import os

from flask import abort, Flask, request
from flask_cors import CORS
from redis import Redis


# Create Flask
app = Flask(__name__)

# Handle Cors
CORS(app=app, origins=["https://kyledle.web.app"], allow_headers=["Authorization"])


# Handle API Key
@app.before_request
def before_request():
    """
    This function is called before each request.
    """
    if (
        request.headers.get("Authorization") != os.environ["API_KEY"]
        and request.method != "OPTIONS"
    ):
        abort(401)


# Create Redis
redis = Redis(host="localhost", port=6379, decode_responses=True)
