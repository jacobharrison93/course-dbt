{{config(materialized = 'table')}}

with orders as (

    select * from {{ref('stg_orders')}}
),

addresses as (
    select * from {{ref('stg_addresses')}}

),

promos as (

    select * from {{ref('stg_promos')}}
),

users as (

    select * from {{ref('stg_user')}}
)

select
    orders.order_id,
    concat(users.first_name, users.last_name) as user_name,
    users.email,
    addresses.address,
    addresses.zipcode,
    addresses.state,
    addresses.country,
    promos.promo_id,
    promos.discount as promo_discount,
    promos.status as promo_status,
    orders.created_at,
    orders.order_cost,
    orders.shipping_cost,
    orders.order_total,
    orders.tracking_id,
    orders.shipping_service,
    orders.estimated_delivery_at,
    orders.delivered_at,
    orders.status,
    case
        when orders.status = 'delivered' then datediff(hour,orders.created_at,orders.delivered_at)
    end as delivery_time_hours
    

    
from orders
left join addresses on orders.address_id = addresses.address_id
left join promos on orders.promo_id = promos.promo_id
left join users on orders.user_id = users.user_id