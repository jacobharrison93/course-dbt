{{config(materialized = 'table')}}

with users as (

    select * from {{ref('stg_user')}}
),

addresses as (
    select * from {{ref('stg_addresses')}}

),

user_orders as (
    select * from {{ref('int_user_orders')}}
)

select
    users.user_id,
    users.first_name,
    users.last_name,
    users.email,
    users.phone_number,
    users.created_at,
    users.updated_at,
    addresses.address,
    addresses.zipcode,
    addresses.state,
    addresses.country,
    user_orders.num_of_orders,
    user_orders.num_of_promo_orders,
    user_orders.total_order_spend,
    user_orders.total_shipping_spend,
    user_orders.total_spend,
    user_orders.oldest_order,
    user_orders.newest_order
        
from users
left join addresses on users.address_id = addresses.address_id
left join user_orders on users.user_id = user_orders.user_id