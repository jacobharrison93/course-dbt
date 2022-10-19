
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
)

select * from view_events

union

select * from order_events