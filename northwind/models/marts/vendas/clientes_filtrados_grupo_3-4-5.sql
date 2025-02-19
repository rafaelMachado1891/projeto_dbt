with order_details as (
    select 
     order_id,
     total_sales
    from {{ ref("int_order_details") }}
),

orders as ( 
    select 
     order_id,
     customer_id
    from {{ ref('int_orders') }}
),

customers as (
    select 
     customer_id,
     company_name
    from {{ ref('int_customers')}}
),

agregate_orders_by_orders_details as (
    select
     c.company_name,
     a.total_sales
    from order_details a
    join orders b
    on b.order_id = a.order_id
    join customers c
    on c.customer_id = b.customer_id
),

customers_by_group as (
    select
        company_name,
        round(sum(total_sales), 2)  as total_sales,
        NTILE(5) OVER (ORDER BY sum(total_sales) DESC) AS customer_group
    from agregate_orders_by_orders_details
    group by
        company_name
    order by 2 DESC
)


select * 
from customers_by_group
where
customer_group in (3,4,5)
