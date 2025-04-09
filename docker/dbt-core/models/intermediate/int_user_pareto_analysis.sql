-- models/int/int_user_pareto_analysis.sql

{{ config(materialized='view') }}

with user_amount as (
    select
    user_id, 
    SUM(amount_received) AS total_amount
    from {{ ref('stg_recharge')}}
    group by `User_ID`
),

user_ranked AS (
  SELECT
    user_id,
    total_amount,
    RANK() OVER (ORDER BY total_amount DESC) AS pareto_rank,
    SUM(total_amount) OVER (ORDER BY total_amount DESC) AS cumsum,
    ROUND(100 * SUM(total_amount) OVER (ORDER BY total_amount DESC) / 
              SUM(total_amount) OVER (), 2) AS cumsum_ratio
  FROM user_amount
)

select
  user_id,
  total_amount,
  pareto_rank,
  cumsum,
  cumsum_ratio,
  CASE
    WHEN cumsum_ratio <= 20 THEN 'Top 20%'
    WHEN cumsum_ratio <= 80 THEN 'Mid 60%'
    ELSE 'Bottom 20%'
  END AS pareto_segment
from user_ranked