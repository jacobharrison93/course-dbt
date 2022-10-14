{{config(materialized = 'table')}}

with sessions as (

    select * from {{ref('int_session_agg')}}
),

users as (
    select * from {{ref('stg_user')}}
)


select
    sessions.session_id,
    sessions.user_id,
    users.first_name,
    users.last_name,
    num_of_page_views,
    num_of_add_to_cart,
    num_of_checkouts,
    num_of_packaged_shipped,
    num_of_events,
    session_start_time,
    session_end_time,
    total_session_time
        
from sessions
left join users on sessions.user_id = users.user_id