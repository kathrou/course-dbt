

{{
    config(
        materialized = 'table'
    )
}}

WITH orders AS (

    SELECT *
    FROM {{ref('int_orders')}}

),

users AS (

    SELECT *
    FROM {{ref('dim_users')}}

),

order_quantity AS (

    SELECT *
    FROM {{ref('int_order_items')}}

),

promos AS (

    SELECT *
    FROM {{ref('int_promos')}}

),

final AS (
    SELECT 
        -- primary key
        o.order_uuid              AS order_uuid,

        -- foreign keys
        u.user_uuid               AS user_uuid,

        --data
        o.address_uuid            AS address_uuid,
        o.promo_uuid              AS promo_uuid,
        o.created_at              AS created_at,
        o.order_cost              AS order_cost,
        o.shipping_cost           AS shipping_cost,
        o.order_total             AS order_total,
        o.tracking_number         AS tracking_number,
        o.shipping_service        AS shipping_service,
        o.estimated_delivery_at   AS estimated_delivery_at,
        o.delivered_at            AS delivered_at,
        o.order_status            AS order_status,
        oq.quantity               AS order_quantity,
        p.discount                AS order_discount
    FROM orders o
    LEFT JOIN users u
        USING(user_uuid)
    LEFT JOIN order_quantity oq
        USING(order_uuid)
    LEFT JOIN promos p
        USING(promo_uuid)

)

SELECT * 
FROM final

