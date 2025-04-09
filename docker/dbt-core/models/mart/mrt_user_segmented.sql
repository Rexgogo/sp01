-- models/mart/mrt_user_recharge_segmented.sql

{{ config(materialized='table') }}

with user_base as (
    select * from {{ ref('int_user_recharge_summary') }}
),

payment as (
    select
        user_id,
        preferred_payment_type,
        payment_type_count,
        preferred_payment_usage_count
    from {{ ref('int_user_payment_behavior') }}
),

device as (
    select
        user_id,
        preferred_device_type,
        device_count
    from {{ ref('int_user_device_behavior') }}
)

select
    u.user_id,
    u.first_recharge_date,
    u.latest_recharge_date,
    u.recharge_days_interval,
    u.total_recharge_amount,
    u.total_recharge_times,
    u.avg_recharge_amount,
    u.max_recharge_amount,

    p.preferred_payment_type,
    p.payment_type_count,
    p.preferred_payment_usage_count,

    d.preferred_device_type,
    d.device_count,

    -- 分群邏輯：儲值金額層級
    case 
        when u.total_recharge_amount >= 10000 then 'high'
        when u.total_recharge_amount >= 3000 then 'medium'
        else 'low'
    end as recharge_tier,

    -- 分群邏輯：活躍程度
    case 
        when u.total_recharge_times >= 20 then 'very_active'
        when u.total_recharge_times >= 5 then 'active'
        else 'inactive'
    end as activity_level,

    -- 分群邏輯：生命週期階段
    case 
        when date_diff(current_date(), u.first_recharge_date, day) <= 30 then 'new'
        when date_diff(current_date(), u.latest_recharge_date, day) > 60 then 'dormant'
        else 'retained'
    end as lifecycle_stage,

    -- 忠誠標籤：只用一種付款方式
    case when p.payment_type_count = 1 then true else false end as is_payment_loyal

from user_base u
left join payment p using (user_id)
left join device d using (user_id)