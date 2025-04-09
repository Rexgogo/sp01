FROM apache/superset:4.1.2

# set workdir
WORKDIR /app

# copy requirements-local.txt to container
COPY requirements-local.txt .

# install requirements
RUN pip install --no-cache-dir -r requirements-local.txt