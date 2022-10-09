{{
    config(
        materialized = 'view',
        unique_key = 'user_uuid'
    )
}}

WITH user_source AS (
    SELECT * FROM {{ source('src_greenery', 'users')}}
),

renamed AS (
    SELECT 
        user_id                   AS user_uuid, 
        first_name                AS first_name,
        last_name                 AS last_name,
        email                     AS email, 
        phone_number              AS phone_number, 
        created_at                AS created_at,
        updated_at                AS updated_at,
        address_id                AS address_uuid
    FROM user_source
)

SELECT * 
FROM renamed