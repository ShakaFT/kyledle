"""
This module allowed to create app.
"""

import os

from celery import Celery, Task
from celery.schedules import crontab
from flask import abort, Flask, request
from flask_cors import CORS
from redis import Redis


# Create Flask
app = Flask(__name__)
app.config.from_mapping(
    CELERY=dict(
        broker_url="redis://localhost",
        imports=("tasks",),
        result_backend="redis://localhost",
        task_ignore_result=True,
    ),
)

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


# Create Celery
class _FlaskTask(Task):  # pylint: disable=abstract-method
    def __call__(self, *args: object, **kwargs: object) -> object:
        with app.app_context():
            return self.run(*args, **kwargs)


celery = Celery(app.name, task_cls=_FlaskTask)
celery.config_from_object(app.config["CELERY"])
celery.conf.beat_schedule = {
    "hello-world": {"task": "tasks.hello_world", "schedule": crontab()},
    "schedule-levels": {"task": "tasks.schedule_levels", "schedule": crontab("0", "0")},
}

celery.set_default()
