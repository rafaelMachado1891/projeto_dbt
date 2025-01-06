with total_orders as (
    select
    sum(unit_price * quantity * (1- discount)) as total_sales,
    order_id
    from {{ ref("int_order_details") }}
    group by
    order_id
),

total_sales_1997 as (
    select
    round(sum(total_sales), 2)  as total_sales
    from total_orders
    join
    {{ ref("int_orders") }} as orders
    on total_orders.order_id = orders.order_id
    where
    extract(year from order_date) = 1997
)

select * from total_sales_1997