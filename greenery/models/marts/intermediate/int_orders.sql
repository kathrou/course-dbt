{{
    config(
        materialized = 'table',
        unique_key = 'order_uuid'
    )
}}

WITH orders AS (

    SELECT *
    FROM {{ref('stg_greenery__orders')}}

),

days_to_deliver AS (

    SELECT 
        order_uuid,
        DATEDIFF(day, created_at, delivered_at) AS days_to_deliver,
        DATEDIFF(day, created_at, estimated_delivery_at) AS estimated_days_to_deliver,
        (estimated_days_to_deliver - days_to_deliver) AS delta_delivery 
    FROM orders

),

final AS (

    SELECT *
    FROM {{ref('stg_greenery__orders')}}
    LEFT JOIN days_to_deliver
        USING(order_uuid)
)

SELECT * 
FROM final