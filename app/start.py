from fastapi import FastAPI
from app.config import Settings, get_settings

settings = get_settings()
app = FastAPI(title=settings.project_name, version=settings.version)


@app.get("/", status_code=200)
def get_index():
    return {'title': settings.project_name, 'author': settings.author, 'version': settings.version}


@app.get('/ping', status_code=200)
def healthcheck():
    return {'status': "Success"}


if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8080, log_level="debug")
