{{
    config(
        materialized = 'table',
        unique_key = 'event_uuid'
    )
}}

WITH final AS (
    SELECT *
    FROM {{ref('stg_greenery__events')}}
)

SELECT * 
FROM final