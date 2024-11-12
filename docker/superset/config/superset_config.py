import os

SQLALCHEMY_DATABASE_URI = f"postgresql://{os.environ.get('POSTGRES_USER')}:{os.environ.get('POSTGRES_PASSWORD')}@postgres:5432/{os.environ.get('POSTGRES_DB')}"
BIGQUERY_CREDENTIALS_PATH = '/app/credentials/credentials.json'
