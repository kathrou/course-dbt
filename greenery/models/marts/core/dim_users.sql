{{
    config(
        materialized = 'table'
    )
}}

WITH users AS (

    SELECT *
    FROM {{ref('int_users')}}

),

orders AS (

    SELECT 
        user_uuid,
        SUM(order_total) AS user_lifetime_purchases,
        MAX(created_at)  AS date_last_order 
    FROM {{ref('int_orders')}} 
    GROUP BY 1

),

final AS (

    SELECT 
        users.user_uuid                      AS user_uuid, 
        users.first_name                     AS first_name,
        users.last_name                      AS last_name,
        users.email                          AS email, 
        users.phone_number                   AS phone_number, 
        users.created_at                     AS created_at,
        users.updated_at                     AS updated_at,
        users.address_uuid                   AS address_uuid,
        orders.user_lifetime_purchases       AS user_lifetime_purchases,
        orders.date_last_order               AS date_last_order
    FROM users 
    LEFT JOIN orders 
        USING(user_uuid)

)

SELECT * 
FROM final