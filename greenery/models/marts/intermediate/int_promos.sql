{{
    config(
        materialized = 'table',
        unique_key = 'promo_uuid'
    )
}}

WITH final AS (
    SELECT *
    FROM {{ref('stg_greenery__promos')}}
)

SELECT * 
FROM final