from celery import Celery
from app.config import get_settings

settings = get_settings()
celery_app = Celery(main=settings.PROJECT_NAME,
                    broker="sqs://",
                    # backend=settings.CELERY_RESULT_BACKEND,
                    include=["app.celery_etl.tasks"])

celery_app.conf.broker_transport_options = {
    "region": "ap-southeast-1",
    'visibility_timeout': 7200,
    'polling_interval': 1
}

if __name__ == "__main__":
    argv = [
        'worker',
        '--loglevel=INFO',
    ]
    celery_app.worker_main(argv)
