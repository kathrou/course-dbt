{{
    config(
        materialized = 'view',
        unique_key = 'address_uuid'
    )
}}

WITH address_source AS (
    SELECT * FROM {{ source('src_greenery', 'addresses')}}
),

renamed AS (
    SELECT 
        address_id                AS address_uuid, 
        address                   AS delivery_address,
        zipcode                   AS delivery_zip_code,
        state                     AS delivery_state,
        country                   AS delivery_country
    FROM address_source
)

SELECT * 
FROM renamed