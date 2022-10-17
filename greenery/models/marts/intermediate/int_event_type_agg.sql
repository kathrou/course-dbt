{{
    config(
        materialized = 'table'
    )
}}

WITH events AS (

    SELECT *
    FROM {{ref('stg_greenery__events')}}

),

final AS (

    SELECT 
        user_uuid,
        session_uuid,
        SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS added_to_cart,
        SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) AS checked_out,
        SUM(CASE WHEN event_type = 'package_shipped' THEN 1 ELSE 0 END) AS package_shipped,
        SUM(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) AS page_view
    FROM events
    GROUP BY 1,2

)


SELECT * 
FROM final