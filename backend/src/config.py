"""
This module allowed to create app.
"""

import logging
import os

from celery import Celery, Task
from celery.schedules import crontab
from flask import abort, Flask, jsonify, request
from flask_cors import CORS
from redis import Redis

import utils.constants as constants
from utils.discord_message import error_message


# Create Flask
app = Flask(__name__)


# Cors Handling
CORS(app=app, origins=["https://kyledle.web.app"], allow_headers=["Authorization"])


# API Key Handling
@app.before_request
def before_request():
    """
    This function is called before each request.
    """
    if (
        request.headers.get("Authorization") != os.environ["API_KEY"]
        and request.method != "OPTIONS"
        and not app.debug
    ):
        abort(401)


# Error Handling
@app.errorhandler(Exception)
def handle_exception(exc: Exception):
    """
    This function is called after each request.
    """
    error_message(exc)
    return jsonify(error="An unhandled exception has occured..."), 500


# Logging Handling
if constants.IS_GUNICORN:
    # See: https://trstringer.com/logging-flask-gunicorn-the-manageable-way
    gunicorn_logger = logging.getLogger("gunicorn.error")
    app.logger.handlers = gunicorn_logger.handlers
    app.logger.setLevel(gunicorn_logger.level)


# Create Redis
redis = Redis(
    decode_responses=True,
    host=os.environ["REDIS_HOST"],
    password=os.environ.get("REDIS_PASSWORD"),
    port=int(os.environ["REDIS_PORT"]),
    username=os.environ.get("REDIS_USERNAME"),
)


# Create Celery
class _FlaskTask(Task):  # pylint: disable=abstract-method
    def __call__(self, *args: object, **kwargs: object) -> object:
        with app.app_context():
            return self.run(*args, **kwargs)


celery = Celery(app.name, task_cls=_FlaskTask)
celery.conf.imports = ("tasks",)
celery.conf.beat_schedule = {
    "hello-world": {"task": "tasks.hello_world", "schedule": crontab()},
    "schedule-levels": {
        "task": "tasks.schedule_levels",
        "schedule": crontab("0", "0"),
    },
}

celery.set_default()
