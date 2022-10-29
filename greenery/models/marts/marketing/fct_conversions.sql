{{
  config(
    materialized='table'
  )
}}

WITH source AS (

    SELECT * 
    FROM {{ ref('int_sessions') }}

),

final AS (

    SELECT
        {{ dbt_utils.surrogate_key(['session_uuid','product_uuid','order_uuid']) }} AS unique_key,
        session_uuid,
        product_uuid,
        order_uuid,
        event_type,
        created_at
    FROM source
)

SELECT * 
FROM final