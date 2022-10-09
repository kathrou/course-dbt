{{
    config(
        materialized = 'view',
        unique_key = 'promo_uuid'
    )
}}

WITH promos_source AS (
    SELECT * FROM {{ source('src_greenery', 'promos')}}
),

renamed AS (
    SELECT 
        promo_id                AS promo_uuid, 
        discount                AS discount,
        status                  AS promo_status
    FROM promos_source
)

SELECT * 
FROM renamed