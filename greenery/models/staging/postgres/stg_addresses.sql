with source as(
SELECT * from {{source('raw','addresses')}}
)

select
    address_id,
    address,
    zipcode,
    state,
    country
from source