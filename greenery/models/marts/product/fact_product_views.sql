
with view_events as (

    select
        session_id,
        event_type,
        product_id 

    from {{ref('stg_events')}}

    where event_type in ('page_view')
),

order_events as (

    select * from {{ref('int_checkout_products')}}
),

products as (

    select * from {{ref('stg_products')}}
),

union_view_order as (

    select * from view_events

    union

    select * from order_events
    order by session_id
)
 
 select 
    union_view_order.*,
    products.name as product_name
 from union_view_order
 left outer join products on union_view_order.product_id = products.product_id
