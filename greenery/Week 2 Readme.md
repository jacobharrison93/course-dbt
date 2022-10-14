### Week 2: Answers to Questions


 1.    What is our user repeat rate?
    
	    -   Repeat Rate = Users who purchased 2 or more times / users who purchased? --> **79.83%**
		 - SQL Code from Snowflake to get answer
			
        ```sql
            with user_order_count as (
				select 
				    user_id,
				    count(order_id) as num_orders
				from dev_db.dbt_jacobharrison93.stg_orders
				group by 1
				)

				select
				    sum(case when num_orders >=2 then 1 else 0 end) as repeat_users,
				    count(distinct user_id) as num_of_users,
				    div0(repeat_users,num_of_users) as repeat_rate
				from user_order_count;
        ```
	
 2.  DAG for my models
		![DAG](https://user-images.githubusercontent.com/111754475/195904300-fb08bd91-ed52-4185-bed8-88bf14ae33a9.PNG)

    
 3.  Tests
	 - I used only the default test of unique and not_null on all my models. Did not dig into creating any custom test but I see the use case.
4. Snapshot
	- New orders for this week were ORDER_ID
		- 05202733-0e17-4726-97c2-0520c024ab85
		- 939767ac-357a-4bec-91f8-a7b25edd46c9
		- 914b8929-e04a-40f8-86ee-357f2be3a2a2
	- SQL
		- ```sql 
			 select order_id, count(order_id) as num_of_orders
			from dev_db.dbt_jacobharrison93.orders_snapshot
			group by 1
			having num_of_orders >1
			```
