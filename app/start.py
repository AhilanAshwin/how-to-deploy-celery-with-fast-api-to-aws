from fastapi import FastAPI
from app.config import Settings, get_settings
from app.celery_etl.tasks import say_hello, say_goodbye

settings = get_settings()
app = FastAPI(title=settings.project_name, version=settings.version)


@app.get("/", status_code=200)
def get_index():
    return {'title': settings.project_name, 'author': settings.author, 'version': settings.version}


@app.get('/ping', status_code=200)
def healthcheck():
    return {'status': "Success"}


@app.get('/say_hello', status_code=200)
def say_hello_greeting(name: str):
    result = say_hello.delay(name)
    greeting = result.get()
    return {'message': greeting}


@app.get('/say_goodbye', status_code=200)
def say_goodbye_greeting(name: str):
    result = say_goodbye.delay(name)
    greeting = result.get()
    return {"message": greeting}


if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8080, log_level="debug")
