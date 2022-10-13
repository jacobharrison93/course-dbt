{{ config(materialized = 'view')}}

select
    distinct order_id,
    count(distinct product_id) as number_of_products,
    sum(quantity) as total_quantity
from {{ref ('stg_order_items')}}
group by 1