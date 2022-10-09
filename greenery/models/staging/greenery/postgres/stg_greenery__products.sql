{{
    config(
        materialized = 'view',
        unique_key = 'product_uuid'
    )
}}

WITH products_source AS (
    SELECT * FROM {{ source('src_greenery', 'products')}}
),

renamed AS (
    SELECT 
        product_id             AS product_uuid, 
        name                   AS product_name,
        price                  AS product_price,
        inventory              AS inventory_amount
    FROM products_source
)

SELECT * 
FROM renamed