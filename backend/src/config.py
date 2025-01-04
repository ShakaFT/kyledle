"""
This module allowed to create app.
"""

import logging
import os

from celery import Celery, Task
from celery.schedules import crontab
from flask import Flask, abort, jsonify, request
from flask_cors import CORS
from redis import Redis
from werkzeug.exceptions import HTTPException

from utils import constants
from utils.discord_message import error_message

# Create Flask
app = Flask(__name__)


# Cors Handling
CORS(app=app, origins=os.environ["ORIGINS"].split(","), allow_headers=["Authorization"])


# API Key Handling
@app.before_request
def before_request():
    """
    This function is called before each request.
    """
    if (
        constants.ENVIRONMENT != "local"
        and request.method != "OPTIONS"
        and request.headers.get("Authorization") != os.environ["API_KEY"]
    ):
        abort(401)


# Error Handling
@app.errorhandler(Exception)
def handle_exception(exc: Exception):
    """
    This function is called after each request.
    """
    if constants.ENVIRONMENT != "prod" or isinstance(exc, HTTPException):
        raise exc

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
    username=os.environ.get("REDIS_USERNAME"),
)


# Create Celery
class _FlaskTask(Task):  # pylint: disable=abstract-method
    def __call__(self, *args: object, **kwargs: object) -> object:
        with app.app_context():
            return self.run(*args, **kwargs)


celery = Celery(app.name, task_cls=_FlaskTask)

# See: https://stackoverflow.com/a/78088996
celery.conf.broker_connection_retry_on_startup = True

celery.conf.imports = ("tasks",)
celery.conf.beat_schedule = {
    "schedule-levels": {"task": "tasks.schedule_levels", "schedule": crontab("0", "0")},
}

celery.set_default()
