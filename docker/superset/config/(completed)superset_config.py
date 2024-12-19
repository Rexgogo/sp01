import os

SQLALCHEMY_DATABASE_URI = 'postgresql://sp01_db_postgres:mypostgres12345@postgres:5432/sp01_db_postgres'
# SQLALCHEMY_DATABASE_URI = f"postgresql://{os.environ.get('POSTGRES_USER')}:{os.environ.get('POSTGRES_PASSWORD')}@postgres:5432/{os.environ.get('POSTGRES_DB')}"
BIGQUERY_CREDENTIALS_PATH = '/app/credentials/credentials.json'


# Security Configuration
SECRET_KEY = os.environ.get('SUPERSET_SECRET_KEY')
ENABLE_PROXY_FIX = True

# Feature Flags
FEATURE_FLAGS = {
    "ENABLE_TEMPLATE_PROCESSING": True,
    "ENABLE_PYTHON_TEMPLATING": True
}

# Cache Config
CACHE_CONFIG = {
    'CACHE_TYPE': 'redis',
    'CACHE_DEFAULT_TIMEOUT': 300,
    'CACHE_KEY_PREFIX': 'superset_',
    'CACHE_REDIS_HOST': 'redis',
    'CACHE_REDIS_PORT': 6379,
    'CACHE_REDIS_DB': 1,
}