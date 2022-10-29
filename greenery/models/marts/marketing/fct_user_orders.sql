

{{
    config(
        materialized = 'table'
    )
}}

WITH orders AS (

    SELECT *
    FROM {{ref('fct_orders')}}

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
        {{ dbt_utils.surrogate_key(['order_uuid','user_uuid','address_uuid']) }}    AS unique_key,
        orders.order_uuid                                                           AS order_uuid,
        orders.user_uuid                                                            AS user_uuid,
        orders.address_uuid                                                         AS address_uuid,
        orders.created_at                                                           AS created_at,
        orders.order_cost                                                           AS order_cost,
        orders.shipping_cost                                                        AS shipping_cost,
        orders.order_total                                                          AS order_total,
        orders.tracking_number                                                      AS tracking_number,
        orders.shipping_service                                                     AS shipping_service,
        orders.estimated_delivery_at                                                AS estimated_delivery_at,
        orders.delivered_at                                                         AS delivered_at,
        orders.order_status                                                         AS order_status,
        order_quantity.quantity                                                     AS order_quantity,
        promos.discount                                                             AS order_discount,
        DATEDIFF(day, created_at, GETDATE())                                        AS days_since_last_order
    FROM orders 
    LEFT JOIN order_quantity 
        USING(order_uuid)
    LEFT JOIN promos 
        USING(promo_uuid)

)

SELECT * 
FROM final

