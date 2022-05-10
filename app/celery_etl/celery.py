from celery import Celery
from app.config import get_settings


settings = get_settings()
celery_app = Celery(main=settings.proj_name,
                    broker=settings.amqp_dsn,
                    backend=settings.redis_dsn,
                    include=[])

if __name__ == "__main__":
    argv = [
        'worker',
        '--loglevel=INFO',
    ]
    celery_app.worker_main(argv)
