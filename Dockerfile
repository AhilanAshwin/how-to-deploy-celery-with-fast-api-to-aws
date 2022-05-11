# Download the base image of python using version 3.10
FROM python:3.10

# Set the working directory 
WORKDIR /code

# Copy the requirements for the project
COPY ./requirements.txt /code/requirements.txt

# Install the requirements with pip 
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# copy fastapi app folder 
COPY ./app /code/app

# Command to run to run application
CMD ["uvicorn", "app.start:app", "--host", "0.0.0.0", "--port", "80"]