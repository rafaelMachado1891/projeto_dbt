with int_order_details as (
    select
        order_id,
        product_id,
        cast(unit_price as decimal),
        cast(quantity as numeric),
        cast(discount as decimal),
        round(cast(sum(unit_price * quantity * (1 - discount)) as decimal), 2) as total_sales
    from {{ ref("stg_order_details") }}
    group by 
        order_id,
        product_id,
        unit_price,
        quantity,
        discount
)

select 
    order_id,
    product_id,
    unit_price,
    discount,
    total_sales
from int_order_details
