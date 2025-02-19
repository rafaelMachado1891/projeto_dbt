

with orders as (
    select
        o.order_id,
        o.customer_id,
        c.company_name
    from 
        {{ ref("int_orders") }} o
    join 
        {{ ref("int_customers") }} c
    on 
        o.customer_id = c.customer_id
),
total_sales_by_customers as (
    select
        o.company_name,
        round(sum(od.total_sales), 2) as total_sales
    from 
        {{ ref("int_order_details") }} od
    join 
        orders o
    on 
        o.order_id = od.order_id
    group by 
        o.company_name
    order by 
        total_sales desc
)

select 
    company_name,
    total_sales
from 
    total_sales_by_customers
