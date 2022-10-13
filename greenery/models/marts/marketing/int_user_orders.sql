{{config(materialized = 'view')}}

select 
    user_id,
    count(distinct order_id) as num_of_orders,
    sum(case when promo_id is not null then 1 else 0 end) as num_of_promo_orders,
    sum(order_cost) as total_order_spend,
    sum(shipping_cost) as total_shipping_spend,
    sum(order_total) as total_spend,
    min(created_at) as oldest_order,
    max(created_at) as newest_order

from {{ref('stg_orders')}}

group by 1