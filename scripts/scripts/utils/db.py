"""
This module contains utility functions to interact with db.
"""

from redis import Redis

from models.RedisConfig import RedisConfig


def get_db(environment: str) -> Redis:
    """
    This module returns db from environment.
    """
    redis_config = RedisConfig(environment)
    return Redis(
        host=redis_config.host,
        port=redis_config.port,
        decode_responses=True,
        username=redis_config.username,
        password=redis_config.password,
    )
