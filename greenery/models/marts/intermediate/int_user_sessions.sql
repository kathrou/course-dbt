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

event_type_aggregate AS (

    SELECT *
    FROM {{ref('int_event_type_agg')}}

),

order_items AS (

    SELECT *
    FROM {{ref('int_order_items')}}

),

final AS (

    SELECT 
        events.session_uuid,
        events.user_uuid,
        events.event_uuid,
        session_length.last_session_event,
        session_length.first_session_event,
        session_length.session_length,
        event_type_aggregate.added_to_cart,
        event_type_aggregate.checked_out,
        event_type_aggregate.package_shipped,
        event_type_aggregate.page_view                
    FROM events 
    LEFT JOIN session_length 
        ON session_length.session_uuid = events.session_uuid
    LEFT JOIN event_type_aggregate 
        ON event_type_aggregate.session_uuid = events.session_uuid

)

SELECT * 
FROM final