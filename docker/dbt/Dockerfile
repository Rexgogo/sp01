FROM python:3.9-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        ssh-client \
        software-properties-common \
        make \
        build-essential \
        ca-certificates \
        libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install dbt-bigquery
RUN RUN pip install --no-cache-dir \
    dbt-core==1.7.2 \
    dbt-bigquery==1.7.2 \
    dbt-postgres==1.7.2

WORKDIR /dbt

# Create directories
RUN mkdir -p /root/.dbt && \
    mkdir -p /root/.gcp && \
    mkdir -p /dbt/models/staging && \
    mkdir -p /dbt/models/intermediate && \
    mkdir -p /dbt/models/mart && \
    mkdir -p /dbt/seeds && \
    touch /dbt/models/staging/example.sql && \
    touch /dbt/models/intermediate/exampl.sql && \
    touch /dbt/models/mart/example.sql && \
    touch /dbt/seeds/sample.csv

# Create example models
RUN echo "SELECT 1 as id, 'test' as name" > /dbt/models/staging/stg_example.sql && \
    echo "SELECT id, name, CURRENT_TIMESTAMP() as loaded_at FROM {{ ref('stg_example') }}" > /dbt/models/intermediate/int_example.sql && \
    echo "SELECT id, name, loaded_at, 'mart' as source FROM {{ ref('int_example') }}" > /dbt/models/mart/mart_example.sql

# Create seed data
RUN echo "id,name\n1,test1\n2,test2" > /dbt/seeds/sample.csv

CMD ["dbt", "run", "--profiles-dir", "/root/.dbt"]