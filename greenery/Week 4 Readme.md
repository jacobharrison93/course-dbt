### Week 4: Answers to Questions


 1. Snapshot
  a. Snapshot
      - New orders for this week were ORDER_ID
        - fb9fbd-56e1-4dcc-b6b2-a3fd91381bb6
        - 020671-7cdf-493c-b008-c48535415611
        - c516e8-b23a-493a-8a5c-bf7b2b9ea995
      - SQL
        - ```sql 
               select *
              from dev_db.dbt_jacobharrison93.orders_snapshot
              where cast(dbt_updated_at as date) >= '2022-10-26'
          ```

2. Product Funnel
     - ```sql
     	select * from DEV_DB.DBT_JACOBHARRISON93.dim_product_funnel;
     	```

3. Reflection
     a. dbt next steps: My ogranization is using dbt today. A few items I think could help would be to use int tables to help cut down on some of the CTE's. We do not use macros a ton but I am sure there are use cases where it would make sense.
     b. Setting up for production: I would make sure to have test throughly setup to test for all use cases. I would also use something like datadiff to help ensure we are not changing tables without expecting it. I would then setup a full run at least once a day with notifications of failure coming to me or others on the team to prevent issues from leaking to end users.


    
