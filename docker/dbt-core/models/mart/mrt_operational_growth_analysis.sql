-- models/sp001/mart/mrt_operational_growth_analysis.sql
{{ config(materialized='table') }}

-- 月營收、利潤與營業利潤率（OPM）計算，並計算 MoM 成長率
with monthly_agg as (
  select
    month,
    coalesce(sum(recharge_amount), 0) + coalesce(sum(membership_revenue), 0) as total_revenue,
    sum(profit) as total_profit,
    round(
      100 * (sum(profit) / nullif(coalesce(sum(recharge_amount), 0) + coalesce(sum(membership_revenue), 0), 0)),
      2
    ) as opm
  from {{ ref('int_profit_detail') }}
  group by month
),

with_lag as (
  select
    *,
    lag(total_revenue) over (order by month) as previous_total_revenue,
    lag(total_profit) over (order by month) as previous_total_profit,
    lag(opm) over (order by month) as previous_opm
  from monthly_agg
)

select
  *,
  case when previous_total_revenue is null or previous_total_revenue = 0 then 0
       else round(100 * ((total_revenue - previous_total_revenue) / abs(previous_total_revenue)), 2)
  end as revenue_growth_rate,

  case when previous_total_profit is null or previous_total_profit = 0 then 0
       else round(100 * ((total_profit - previous_total_profit) / abs(previous_total_profit)), 2)
  end as profit_growth_rate,

  case when previous_opm is null or previous_opm = 0 then 0
       else round(100 * ((opm - previous_opm) / abs(previous_opm)), 2)
  end as opm_growth_rate
from with_lag
order by month
