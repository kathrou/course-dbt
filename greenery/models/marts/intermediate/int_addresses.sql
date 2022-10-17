{{
    config(
        materialized = 'table',
        unique_key = 'address_uuid'
    )
}}

WITH final AS (

    SELECT *
    FROM {{ref('stg_greenery__addresses')}}
    
)

SELECT * 
FROM final