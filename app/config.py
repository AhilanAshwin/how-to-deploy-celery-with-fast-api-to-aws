from functools import lru_cache
from pydantic import BaseSettings, RedisDsn, AmqpDsn


class Settings(BaseSettings):
    PROJECT_NAME: str
    VERSION: str
    AUTHOR: str
    ENVIRONMENT: str
    CELERY_RESULT_BACKEND: str
    CELERY_BROKER_URL: str

    class Config:
        env_file = "dev.env"
        env_file_encoding = 'utf-8'


@lru_cache
def get_settings():
    return Settings()
