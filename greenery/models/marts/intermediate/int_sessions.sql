{{
    config(
        materialized = 'table'
    )
}}

WITH events AS (

    SELECT *
    FROM {{ref('int_events')}}

), 

session_length AS (

    SELECT 
        session_uuid,
        MAX(created_at) AS last_session_event,
        MIN(created_at) AS first_session_event,
        {{ calculate_session_length('last_session_event,first_session_event') }} AS session_length
    FROM events
    GROUP BY 1

),

order_items AS (

    SELECT *
    FROM {{ref('int_order_items')}}

),

final AS (

    SELECT 
        events.user_uuid,
        events.event_uuid,
        events.session_uuid,
        order_items.product_uuid, 
        order_items.order_uuid,             
        order_items.quantity,    
        session_length.last_session_event,
        session_length.first_session_event,
        session_length.session_length,
        events.event_type,
        events.created_at    
    FROM events 
    LEFT JOIN session_length 
        ON session_length.session_uuid = events.session_uuid
    LEFT JOIN order_items
        ON order_items.order_uuid = events.order_uuid

)

SELECT * 
FROM final