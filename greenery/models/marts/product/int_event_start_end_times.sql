{{config(materialized = 'view')}}

with session_events as (
    select * from {{ref('stg_events')}}
),

event_end_time as (

    select 
        event_id,
        session_id,
        event_type,
        created_at as end_time
    from session_events
),

int_event_start_time as ( --provides a list of related session_ids that are greater than the start time. We are looking for the minimum value in the next step to find the end time
    select
        event_end_time.event_id,
        event_end_time.session_id,
        session_events.created_at
    from event_end_time
    left join session_events on event_end_time.session_id = session_events.session_id and  session_events.created_at < event_end_time.end_time
),

event_start_time as (

    select
        event_id,
        max(created_at) as start_time
    from int_event_start_time
    group by 1
)

select 
   session_events.event_id,
   session_events.event_type,
   session_events.session_id,
   coalesce(event_start_time.start_time, event_end_time.end_time) as start_time,
   event_end_time.end_time,
   coalesce(datediff(minute,start_time,end_time),0) as event_time_minutes

from session_events
    left join event_start_time on session_events.event_id = event_start_time.event_id
    left join event_end_time on session_events.event_id = event_end_time.event_id