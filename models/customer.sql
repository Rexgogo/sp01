{{config(materialized="table")}}

WITH customers AS (
    SELECT * FROM {{ ref('stg_customers') }}
), orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
), orders_grouped_by_customer_id AS (
    SELECT 
        user_id,
        count(id) AS num_of_orders
    FROM orders
    GROUP BY user_id
), customers_joined_with_orders AS (
    SELECT
        t0.id AS customer_id,
        t0.first_name,
        t0.last_name,
        coalesce(t1.num_of_orders, 0) AS num_of_orders
    FROM customers AS t0
    LEFT JOIN orders_grouped_by_customer_id AS t1
    ON t0.id = t1.user_id
)

SELECT * FROM customers_joined_with_orders
ORDER BY customer_id