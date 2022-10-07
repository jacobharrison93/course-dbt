with source as(
SELECT * from {{source('raw','products')}}
)

select
    product_id,
    name,
    price,
    inventory
from source