{% snapshot orders_snapshot %}

    {{
    config(
        target_database = 'dev_db',
        target_schema = 'dbt_jacobharrison93',
        strategy='check',
        unique_key='order_id',
        check_cols=['status'],
    )
    }}

    select * from {{ref('stg_orders')}}

{% endsnapshot %}