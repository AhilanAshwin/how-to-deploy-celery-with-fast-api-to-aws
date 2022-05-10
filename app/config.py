from functools import lru_cache
from pydantic import BaseSettings


class Settings(BaseSettings):
    project_name: str = "how-to-deploy-celery-to-aws"
    version: str = "0.1.0"
    author: str = "Ahilan Ashwin"


@lru_cache
def get_settings():
    return Settings()
