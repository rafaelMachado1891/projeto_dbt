with int_orders_details_select_columns as (
    select * from 
    {{ ref("stg_orders_details")}}
)
 select * from int_orders_details_select_columns