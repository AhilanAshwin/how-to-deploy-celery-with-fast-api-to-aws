from functools import lru_cache
from pydantic import BaseSettings

# Set up appropriate validation


class Settings(BaseSettings):
    PROJECT_NAME: str
    VERSION: str
    AUTHOR: str
    ENVIRONMENT: str
    CELERY_RESULT_BACKEND: str
    CELERY_BROKER_URL: str

    class Config:
        env_file = "prod.env"
        env_file_encoding = 'utf-8'


@lru_cache
def get_settings():
    return Settings()
