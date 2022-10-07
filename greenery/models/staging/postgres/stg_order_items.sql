with source as(
SELECT * from {{source('raw','order_items')}}
)

select
    order_id,
    product_id,
    quantity
from source