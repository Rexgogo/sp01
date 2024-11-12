FROM apache/superset:latest

USER root

# Install additional packages
RUN pip install --no-cache-dir \
    psycopg2-binary \
    sqlalchemy-bigquery \
    google-cloud-bigquery

COPY /config/superset_config.py /app/config/superset_config.py
COPY /credentials/credentials.json /app/credentials/credentials.json

USER superset