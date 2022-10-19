{{
    config(
        materialized = 'table'
    )
}}

WITH products AS (

    SELECT *
    FROM {{ref('int_products')}}

),

total_sold AS (

    SELECT 
        product_uuid,
        SUM(quantity) AS total_sold
    FROM {{ref('int_order_items')}}
    GROUP BY 1

),

final AS (

    SELECT 
        product_uuid             AS product_uuid, 
        product_name             AS product_name,
        product_price            AS product_price,
        inventory_amount         AS inventory_amount,
        total_sold               AS total_sold
    FROM products 
    LEFT JOIN total_sold 
        USING(product_uuid)

)

SELECT * 
FROM final