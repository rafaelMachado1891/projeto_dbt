

with orders as (
    select 
        order_id,
        order_date
    from  {{ ref("int_orders") }}
),

order_details as (
    select
        order_id,
        total_sales
    from  {{ ref("int_order_details") }}
),

total_sales_1997 as (
    select
        sum(od.total_sales) as total_sales
    from  order_details od
    join 
        orders o
    on 
        od.order_id = o.order_id
    where 
        extract(year from o.order_date) = 1997
)

select total_sales from total_sales_1997
