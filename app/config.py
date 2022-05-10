from functools import lru_cache
from pydantic import BaseSettings, RedisDsn, AmqpDsn


class Settings(BaseSettings):
    project_name: str = "how-to-deploy-celery-to-aws"
    version: str = "0.1.0"
    author: str = "Ahilan Ashwin"
    # To be changed to sqs and elastic cache
    redis_dsn: RedisDsn = 'redis://localhost:6379'
    amqp_dsn: AmqpDsn = 'amqp://guest:guest@localhost:5672'


@lru_cache
def get_settings():
    return Settings()
