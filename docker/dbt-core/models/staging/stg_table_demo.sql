-- models/sp001/staging/stg_operation.sql

{{ config(
  materialized='incremental',
  unique_key='date',
  partition_by={'field': 'date', 'data_type': 'date'}) }}

-- 將來源表的欄位重新命名與轉型，清理欄位名稱
with operation as(
  select
  cast(`date` as date) as date,
  `channel Revenue` as channel_revenue,
  `recharge Amount` as recharge_amount,
  `membership Revenue` as membership_revenue,
  `Post-deduction Cost` as post_deduction_cost
  from {{ source('bq_raw_data', 'operation') }}
  -- where _PARTITIONDATE is not null

  {% if is_incremental() %}
    -- 第二次以後的執行，只處理今天的資料
    where cast(`date` as date) = current_date("Asia/Taipei")
  {% endif %}
) 

select * from operation