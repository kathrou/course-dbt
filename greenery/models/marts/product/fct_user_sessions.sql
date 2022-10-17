{{
    config(
        materialized = 'table'
    )
}}

WITH user_sessions AS (

    SELECT *
    FROM {{ref('int_user_sessions')}}

),

users AS (

    SELECT *
    FROM {{ref('dim_users')}}

)

final AS (

    SELECT *
    FROM user_sessions 

)

SELECT * 
FROM final

