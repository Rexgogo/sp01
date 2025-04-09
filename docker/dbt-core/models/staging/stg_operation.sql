{{config(
  materialized='incremental',
  unique_key='date',
  partition_by={'field': 'date', 'data_type': 'date'})}}

with source as(
    select
        cast(`date` as date) as date,
        `channel Revenue` as channel_revenue
    from {{source('bq_raw_data', 'operation')}}
    
    {% if is_incremental() %}
    -- 第二次以後的執行，只處理今天的資料
    where cast(`date` as date) = current_date("Asia/Taipei")
    {% endif %}
)

select * from source 