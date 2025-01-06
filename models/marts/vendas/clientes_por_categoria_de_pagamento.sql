with orders as (
    select
        a.order_id,
        b.company_name
    from {{ ref("int_orders") }} a
    join {{ ref("int_customers") }} b
        on b.customer_id = a.customer_id
),
order_details as (
    select
        *
    from {{ ref("int_order_details") }}
),
customers_by_group as (
    select
        o.company_name,
        round(sum(od.total_sales), 2)  as total_sales,
        NTILE(5) OVER (ORDER BY sum(od.quantity * od.unit_price * (1 - od.discount)) DESC) AS customer_group
    from orders o
    join order_details od
        on o.order_id = od.order_id
    group by
        o.company_name
)

select * 
from customers_by_group
