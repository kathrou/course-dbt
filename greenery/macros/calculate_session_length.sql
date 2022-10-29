{% macro calculate_session_length(first_session_event, last_session_event) %}

    TIMESTAMPDIFF(minute,first_session_event,last_session_event) 

{% endmacro %}