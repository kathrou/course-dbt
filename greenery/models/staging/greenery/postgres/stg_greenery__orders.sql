{{
    config(
        materialized = 'view',
        unique_key = 'order_uuid'
    )
}}

WITH orders_source AS (

    SELECT * 
    FROM {{ source('src_greenery', 'orders')}}
    
),

renamed AS (
    SELECT 
        order_id                AS order_uuid, 
        user_id                 AS user_uuid,
        promo_id                AS promo_uuid,
        address_id              AS address_uuid,
        created_at              AS created_at,
        order_cost              AS order_cost,
        shipping_cost           AS shipping_cost,
        order_total             AS order_total,
        tracking_id             AS tracking_number,
        shipping_service        AS shipping_service,
        estimated_delivery_at   AS estimated_delivery_at,
        delivered_at            AS delivered_at,
        status                  AS order_status
    FROM orders_source
)

SELECT * 
FROM renamed