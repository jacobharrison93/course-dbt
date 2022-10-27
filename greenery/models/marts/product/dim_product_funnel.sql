with sessions as (

select * from {{ref('fact_page_views')}}
),

page_view_sess as(

    select 
        'Page Views' as funnel_step,
        count(distinct(case when num_of_page_view >= 1 then session_id end)) as num_of_sessions
    from sessions
),

cart_sess as(

    select
        'Add to Cart' as funnel_step,
        count(distinct(case when num_of_add_to_cart >= 1 then session_id end)) as num_of_sessions
    from sessions
),

checkout_sess as(

    select
        'Checkouts' as funnel_step,
        count(distinct(case when num_of_checkout >=1 then session_id end)) as num_of_sessions
    from sessions
),

funnel as (
select * from page_view_sess
union
select * from cart_sess
union
select * from checkout_sess
)

select 
    funnel_step,
    num_of_sessions,
    lag(num_of_sessions,1) over (order by num_of_sessions desc) as lag,
    1-(num_of_sessions/lag) as percent_drop_off
from funnel