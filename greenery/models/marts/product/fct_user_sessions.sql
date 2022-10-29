{{
    config(
        materialized = 'table'
    )
}}

WITH user_sessions AS (

    SELECT *
    FROM {{ref('int_user_sessions')}}

),

final AS (

    SELECT         
        {{ dbt_utils.surrogate_key(['session_uuid','user_uuid','event_uuid']) }}    AS unique_key,
        *
    FROM user_sessions 

)

SELECT * 
FROM final

