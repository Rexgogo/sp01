{{ config(materialized='table') }}

with payment_counts as (
    select
        user_id,
        payment_type,
        count(*) as usage_count,
        row_number() over (partition by user_id order by count(*) desc) as rank
    from {{ ref('stg_recharge') }}
    group by user_id, payment_type
),

payment_summary as(
    select 
        user_id,
        count(*) as payment_type_count,
        max(case when rank=1 then payment_type end) as preferred_payment_type,
        max(case when rank=1 then usage_count end) as preferred_payment_usage_count
    from payment_counts
    group by user_id
)

select * from payment_summary