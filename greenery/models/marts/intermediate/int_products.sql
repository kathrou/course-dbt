{{
    config(
        materialized = 'table',
        unique_key = 'product_uuid'
    )
}}

WITH final AS (
    SELECT *
    FROM {{ref('stg_greenery__products')}}
)

SELECT * 
FROM final