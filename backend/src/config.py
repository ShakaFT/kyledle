"""
This module allowed to create app.
"""

from flask import Flask
from redis import Redis


# Create Flask
app = Flask(__name__)
app.config["JSON_AS_ASCII"] = False
# Create Redis
redis = Redis(host="localhost", port=6379, decode_responses=True)
