{{config(materialized = 'view')}}

{% set event_types = dbt_utils.get_column_values(
    table=ref('stg_events'),
    column='event_type'
) %}

with sessions as (

    select * from {{ref('stg_events')}}
)

select
    session_id,
    user_id,
    {%- for event_type in event_types %}
    sum(case when event_type = '{{event_type}}' then 1 else 0 end) as num_of_{{event_type}}
    {%- if not loop.end %},{% endif %}
    {% endfor -%}
    count(distinct event_id) as num_of_events,
    count(distinct order_id) as num_of_orders,
    min(created_at) as session_start_time,
    max(created_at) as session_end_time,
    datediff(minutes,session_start_time,session_end_time) as total_session_time
        
from sessions
group by 1,2