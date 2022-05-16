# how-to-deploy-celery-with-fast-api-to-aws

This repository to serves as a guideline as to how to deploy a celery application with fastapi onto AWS. Celery is a async task queue to relegate work outside the HTTP resposne cycle. That way your WSGI isn't tied down to long running process. In other words, implementing a queue improves the response time of your web server.

The aws infrastructure is automated with terraform code in the `aws` folder of the code repo.
