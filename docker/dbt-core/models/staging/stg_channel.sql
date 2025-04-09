-- models/sp001/staging/stg_operation.sql

{{ config(materialized='view') }}

-- 將來源表的欄位重新命名與轉型，清理欄位名稱
select
  cast(`date` as date) as date,
  `channel Revenue` as channel_revenue,
  `recharge Amount` as recharge_amount,
  `membership Revenue` as membership_revenue,
  `Post-deduction Cost` as post_deduction_cost
from {{ source('bq_raw_data', 'operation') }}
where _PARTITIONDATE is not null