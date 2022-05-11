from app.celery_etl.celery import celery_app


@celery_app.task
def say_hello(name: str) -> str:
    name = name.strip()
    return f"Hello {name}! Welcome back!"


@celery_app.task
def say_goodbye(name: str) -> str:
    name = name.strip()
    return f"Goodbye {name}. Hope to see you again sometime!"
