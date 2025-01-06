with int_orders_details_select_columns as (
    select
     order_id,
     product_id,
     cast(unit_price as decimal) as unit_price,
     cast(quantity as int) as quantity,
     cast(discount as decimal) discount,
     cast(sum(unit_price * quantity * (1-discount))as decimal) as total_sales
    from 
    {{ ref("stg_orders_details")}}
    group by
    order_id,
    product_id,
    unit_price,
    quantity,
    discount
)
 select * from int_orders_details_select_columns