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

    SELECT *
    FROM user_sessions 

)

SELECT * 
FROM final

