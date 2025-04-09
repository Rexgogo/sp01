-- models/sp001/staging/stg_recharge.sql

{{ config(
  materialized='incremental',
  unique_key='order_completed_date',
  partition_by={'field': 'order_completed_date', 'data_type': 'order_completed_date'}
  ) }}

with source as(
  select
    cast(`Order Time` as date) as order_created_date,
    timestamp(`Order Time`) as order_created_at_utc,
    cast(`Order Completion Time` as date) as order_completed_date,
    timestamp(`Order Completion Time`) as order_completed_at_utc,
    cast(`User ID` as string) as user_id,
    `Order Number` as order_number,
    `Purpose` as order_purpose,
    `Payment Gateway` as payment_gateway,
    `Payment Type` as payment_type,
    `Order Type` as order_type,
    cast(`Recharge Amount` as float64) as recharge_amount,
    cast(`Amount Received` as float64) as amount_received,
    `Device Type` as device_type
  from {{ source('bq_raw_data', 'recharge') }}
  
  {% if is_incremental() %}
    -- 第二次以後的執行，只處理今天的資料
    where cast(`date` as date) = current_date("Asia/Taipei")
  {% endif %}
)

select * from source