FROM apache/superset:latest

# set workdir
WORKDIR /app

# copy requirements-local.txt to container
COPY requirements-local.txt .

# install requirements
RUN pip install --no-cache-dir -r requirements-local.txt