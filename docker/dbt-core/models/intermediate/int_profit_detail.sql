-- models/sp001/intermediate/int_profit_detail.sql
{{ config(materialized='table') }}

-- 將每筆 daily record 加上時間維度欄位與利潤計算
select
  date,
  extract(year from date) as year,
  extract(quarter from date) as quarter,
  format_timestamp('%Y-%m', date) as month,
  format_date('%m', date) as month_number,
  format_date('%d', date) as day,
  extract(dayofweek from date) as weekday_number,
  format_date('%A', date) as weekday,
  channel_revenue,
  recharge_amount,
  membership_revenue,
  post_deduction_cost,
  coalesce(channel_revenue, 0) + coalesce(membership_revenue, 0) as profit
from {{ ref('stg_operation') }}
