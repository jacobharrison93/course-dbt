with order_events as (

    select *

    from {{ref('stg_events')}}

    where event_type in ('checkout')
),

product_orders as(

    select * from {{ref('stg_order_items')}}
)

select
    order_events.session_id,
    order_events.event_type,
    product_orders.product_id
from order_events
left outer join product_orders on order_events.order_id = product_orders.order_id

