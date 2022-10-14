{{config(materialized = 'view')}}

with sessions as (

    select * from {{ref('stg_events')}}
)

select
    session_id,
    user_id,
    sum(case when event_type = 'page_view' then 1 else 0 end) as num_of_page_views,
    sum(case when event_type = 'add_to_cart' then 1 else 0 end) as num_of_add_to_cart,
    sum(case when event_type = 'checkout' then 1 else 0 end) as num_of_checkouts,
    sum(case when event_type = 'package_shipped' then 1 else 0 end) as num_of_packaged_shipped,
    count(distinct event_id) as num_of_events,
    count(distinct order_id) as num_of_orders,
    min(created_at) as session_start_time,
    max(created_at) as session_end_time,
    datediff(minutes,session_start_time,session_end_time) as total_session_time
        
from sessions
group by 1,2