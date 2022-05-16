# how-to-deploy-celery-with-fast-api-to-aws

This repository to serves as a guideline as to how to deploy a celery application with fastapi onto AWS. Celery is a async task queue to relegate work outside the HTTP resposne cycle. That way your WSGI server isn't tied down to long running process. In other words, implementing a queue improves the response time of your web server.

This architecture is useful when deploying a machine learning production system, especially when your model takes a few seconds to return predictions. Feature engineering tasks can be completed in parallel reducing inference times since the execution is no longer a single threaded process.

The aws infrastructure is automated with terraform in the `aws` folder of the code repo.

#TODO:

- [x] Add documentation
- [ ] Outline env variables
- [ ] CI/CD for application
