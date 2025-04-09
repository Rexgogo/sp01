{{ config(materialized='table') }}

with base as (
    select
        user_id,
        device_type
    from {{ ref('stg_recharge') }}
),

device_ranked as (
    select
        user_id,
        device_type,
        count(*) as device_count,
        row_number() over (partition by user_id order by count(*) desc) as rank
    from base
    group by user_id, device_type
)

select
    user_id,
    device_type as preferred_device_type,
    device_count
from device_ranked
where rank = 1
