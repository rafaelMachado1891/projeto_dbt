with int_orders_select_columns as (
    select 
     order_id,
     customer_id,
     employee_id,
     order_date
    from {{ ref("stg_orders") }}
)

select * from int_orders_select_columns