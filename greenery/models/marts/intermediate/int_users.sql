{{
    config(
        materialized = 'table',
        unique_key = 'user_uuid'
    )
}}

WITH final AS (
    SELECT *
    FROM {{ref('stg_greenery__users')}}
)

SELECT * 
FROM final