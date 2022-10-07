### Week 1: Answers to Questions


 1.   How many users do we have? --> **130 Users**
		 - SQL Code from Snowflake to get answer
			
        ```sql
            select count(distinct user_id)
            from dev_db.dbt_jacobharrison93.stg_user
        ```
	
 2.   On average, how many orders do we receive per hour? --> **7.52 Orders Per Hour**
         - SQL Code from Snowflake to get answer

        ```sql
              with hourly_orders as (
              select date_trunc(hh,created_at), count(distinct order_id) as orders_per_hour
              from dev_db.dbt_jacobharrison93.stg_orders
              group by 1
              )

            select avg(orders_per_hour) from hourly_orders;
        ```
    
 3.  On average, how long does an order take from being placed to being delivered? --> **3 days 21 hours 24 minutes 11 seconds**
      -  SQL Code from Snowflake to get answer
         ```sql
              with seconds_between as (

                select datediff(second,created_at, delivered_at) as seconds
                from dev_db.dbt_jacobharrison93.stg_orders
            ),

            avg_time_between as (

                select avg(seconds) as avg_seconds from seconds_between
            ),

            human_readable_time as (

                select 
                    avg_seconds,
                    avg_seconds % 60 as seconds_part,
                    avg_seconds % 3600 as minutes_part,
                    avg_seconds % (3600 * 24) as hours_part,
                    concat(
                        floor(avg_seconds/3600/24), ' days ',
                        floor(hours_part/3600), ' hours ',
                        floor(minutes_part/60),' minutes ',
                        floor(seconds_part), ' seconds'    
                    ) as difference
                from avg_time_between

            )

            select * from human_readable_time

          ```

 4.   How many users have only made one purchase? Two purchases? Three+ purchases? 
      - Answer: 

           | TYPE_OF_CUSTOMER |	NUM_OF_USERS |
           |------------------|--------------|
           | Single Order	    |         25   |
           | Two Orders	      |           28 |
           | Three or More Orders	| 71 |
      - SQL Code from Snowflake to get answer
      
          ```sql
              with avg_orders_per_user as(
              select user_id, count(distinct order_id) as num_of_purchases
              from dev_db.dbt_jacobharrison93.stg_orders
              group by 1
          ),

          one_order as (

              select count(distinct user_id) as num_of_users
              from avg_orders_per_user
              where num_of_purchases <=1

          ),

          two_orders as (

              select count(distinct user_id) as num_of_users
              from avg_orders_per_user
              where num_of_purchases = 2

          ),

          three_orders as (

              select count(distinct user_id) as num_of_users
              from avg_orders_per_user
              where num_of_purchases >= 3

          )

          select 'Single Order' as type_of_customer, * from one_order 
          union
          select 'Two Orders' as type_of_customer, *  from two_orders
          union
          select 'Three or More Orders' as type_of_customer, *  from three_orders;
          ```

        
  5. On average, how many unique sessions do we have per hour? --> **11.79 Unique Sessions Per Hour**
      - SQL Code from Snowflake to get answer

        ```sql
            with unique_sess_by_early_create as (
            select 
                distinct session_id as unique_sessions, 
                min(created_at) as earliest_created
            from dev_db.dbt_jacobharrison93.stg_events
            group by 1
        ),

        unique_sess_by_hour as (

        select
            count(distinct unique_sessions) as num_sess_by_hour, 
            date_trunc(hour,earliest_created) as hours
        from unique_sess_by_early_create
        group by 2
        )

        select avg(num_sess_by_hour) from unique_sess_by_hour
        ```
