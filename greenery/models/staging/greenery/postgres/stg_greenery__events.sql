{{
    config(
        materialized = 'view',
        unique_key = 'event_uuid'
    )
}}

WITH events_source AS (
    SELECT * FROM {{ source('src_greenery', 'events')}}
),

renamed AS (
    SELECT 
        event_id                  AS event_uuid, 
        session_id                AS session_uuid,
        user_id                   AS user_uuid,
        page_url                  AS page_url,
        created_at                AS created_at,
        event_type                AS event_type,
        order_id                  AS order_uuid,
        product_id                AS product_uuid
    FROM events_source
)

SELECT * 
FROM renamed