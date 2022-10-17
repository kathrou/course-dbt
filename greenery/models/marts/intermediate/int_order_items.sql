{{
    config(
        materialized = 'table',
        unique_key = 'order_uuid'
    )
}}

WITH final AS (
    SELECT *
    FROM {{ref('stg_greenery__order_items')}}
)

SELECT * 
FROM final