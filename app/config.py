from functools import lru_cache
from pydantic import BaseSettings, RedisDsn, AmqpDsn


class Settings(BaseSettings):
    PROJECT_NAME: str = "how-to-deploy-celery-to-aws"
    VERSION: str = "0.1.0"
    AUTHOR: str = "Ahilan Ashwin"
    # To be changed to sqs and elastic cache
    CELERY_RESULT_BACKEND: RedisDsn
    CELERY_BROKER_URL: AmqpDsn

    class Config:
        env_file = ".env"
        env_file_encoding = 'utf-8'


@lru_cache
def get_settings():
    return Settings()
