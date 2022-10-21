### Week 3: Answers to Questions


 ### Week 2: Answers to Questions


 1.    Conversion Rate
  a. Overall Conversion Rate: __62.45%__    
			
        ```sql
           select
             count(distinct session_id) as num_of_sessions,
             count(distinct (case when event_type = 'checkout' then session_id end)) as converted_sessions,
             converted_sessions/num_of_sessions as conversion_rate
           from dev_db.dbt_jacobharrison93.fact_product_views;
        ```
        
   b. Conversion Rate by Product __(Top 5 Listed Below)__
   
   
   |PRODUCT_NAME|NUM_OF_SESSIONS|CONVERTED_SESSIONS|CONVERSION_RATE|
   |---------------------|------------------|---------------------|----------------|
   | String of pearls	| 64	| 39 |	0.609375 |
   | Arrow Head	| 63	| 35	| 0.555556 |
   | Cactus	|55	| 30 |	0.545455 |
   | ZZ Plant	| 63	| 34 |	0.539683 |
   | Bamboo	| 67	| 36 |	0.537313 |
   

   ```sql
   
	     select
	        product_name,
	        count(distinct session_id) as num_of_sessions,
	        count(distinct (case when event_type = 'checkout' then session_id end)) as converted_sessions,
	        converted_sessions/num_of_sessions as conversion_rate
	     from dev_db.dbt_jacobharrison93.fact_product_views
	     group by 1
	     order by 4 desc
       
   ```

2. Macro
     - Macro is under the int_session_agg.sql file for looping through the event_types.

3. Hooks
     - Post Hook for granting permission is in the dbt_project.yml file under the 

4. dbt Packages
     - dbt-utils used example above for int_session_agg.sgl
     - test: used combination_of_columns test in _product_models.yml file for int_checkout_producs

5. Snapshot
      - New orders for this week were ORDER_ID
        - ORDER_ID
          - 8385cfcd-2b3f-443a-a676-9756f7eb5404
          - 5741e351-3124-4de7-9dff-01a448e7dfd4
          - e24985f3-2fb3-456e-a1aa-aaf88f490d70
      - SQL
        - ```sql 
               select *
                from dev_db.dbt_jacobharrison93.orders_snapshot
                where cast(dbt_updated_at as date) >= '2022-10-16'
          ```
      
	
 6.  DAG for my models
	![DAG](https://user-images.githubusercontent.com/111754475/197208317-cf8487e1-7a29-4399-bdeb-b0d617e03596.PNG)


    

