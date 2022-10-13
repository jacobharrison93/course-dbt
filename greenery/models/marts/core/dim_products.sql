{{config(materialized = 'view')}}

with products as (

    select * from {{ref('stg_products')}}
),

products_agg as (

    select * from {{ref('int_order_items_product')}}
),

products_spend as (
    
    select
    products.product_id,
    products.inventory * products.price as holding_cost,
    products_agg.total_quantity_ordered * products.price as total_revenue

from products
left join products_agg on products.product_id = products_agg.product_id

)

select
    products.product_id,
    products.name,
    products.price,
    products.inventory,
    products_agg.num_of_orders,
    products_agg.total_quantity_ordered,
    products_spend.holding_cost,
    products_spend.total_revenue

from products
left join products_agg on products.product_id = products_agg.product_id
left join products_spend on products.product_id = products_spend.product_id