FROM ghcr.io/dbt-labs/dbt:latest

WORKDIR /usr/app

COPY ./dbt_sp001 /usr/app/
COPY ./profiles.yml /root/.dbt/

ENV DBT_PROFILES_DIR=/root/.dbt