{{ config(materialized='table') }}

with source as(
    select 
        user_id,
        order_created_date,
        recharge_amount
    from {{ ref('stg_recharge')}}
),

summary as (
    select 
        user_id,
        min(order_created_date) as first_recharge_date,
        max(order_created_date) as latest_recharge_date,
        date_diff(max(order_created_date), min(order_created_date), day) as recharge_days_interval,
        count(*) as total_recharge_times,
        sum(recharge_amount) as total_recharge_amount,
        avg(recharge_amount) as avg_recharge_amount,
        max(recharge_amount) as max_recharge_amount,
        min(recharge_amount) as min_recharge_amount, 
    from source
    group by user_id
)

select * from summary