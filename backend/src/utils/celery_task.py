"""
This module contains Celery Task models.
"""

from billiard.einfo import ExceptionInfo
from celery import Task, shared_task

from utils.discord_message import error_message


def celery_task(*args, **kwargs):
    """
    This decorators extends from `celery.shared_task`.
    """
    if "base" not in kwargs:
        kwargs["base"] = CeleryTask
    return shared_task(*args, **kwargs)


class CeleryTask(Task):
    """
    This class implements Celery task handling.
    """

    def on_failure(
        self,
        exc: Exception,
        task_id: str,
        args: tuple,
        kwargs: dict,
        einfo: ExceptionInfo,
    ):
        error_message(exc)

    def run(self, *args, **kwargs):
        pass
