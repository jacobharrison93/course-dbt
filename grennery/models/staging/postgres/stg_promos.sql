with source as(
SELECT * from {{source('raw','promos')}}
)

select
    promo_id,
    discount,
    status
from source