"""
This module contains RedisConfig class.
"""

import os

from utils import constants


class RedisConfig:
    """
    This class represents Redis Config.
    """

    def __init__(self, environment: str):
        assert (
            environment in constants.ENVIRONMENTS
        ), f"Environment {environment} unknown"
        self.host = os.environ.get("REDIS_HOST", "localhost")
        self.username = os.environ.get("REDIS_USERNAME")
        self.password = os.environ.get("REDIS_PASSWORD")

        if environment == "dev":
            self.port = 6380
        elif environment == "prod":
            self.port = 6381
        else:  # local
            self.port = 6379
            self.username = None
            self.password = None
