{{
    config(
        materialized = 'view',
        unique_key = 'order_uuid'
    )
}}

WITH order_items_source AS (
    SELECT * FROM {{ source('src_greenery', 'order_items')}}
),

renamed AS (
    SELECT 
        order_id                  AS order_uuid, 
        product_id                AS product_uuid,
        quantity                  AS quantity
    FROM order_items_source
)

SELECT * 
FROM renamed