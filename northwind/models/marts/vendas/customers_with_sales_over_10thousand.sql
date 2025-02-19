
with customers_UK as (
    select
        customer_id,
        company_name,
        country
    from 
        {{ ref('int_customers') }}
    where 
        country = 'UK'
),

orders as (
    select 
        order_id,
        customer_id
    from 
        {{ ref('int_orders') }}
),

orders_customer_UK as (
    select 
        c.customer_id,
        c.company_name,
        o.order_id
    from 
        customers_UK c
    join 
        orders o 
    on 
        c.customer_id = o.customer_id
),

order_details as (
    select
        order_id,
        sum(total_sales) as total_sales
    from 
        {{ ref('int_order_details') }}
    group by 
        order_id
),

sales_by_customers_UK as (
    select
        oc.company_name,
        round(sum(od.total_sales), 2) as total_sales
    from 
        order_details od
    join 
        orders_customer_UK oc
    on 
        od.order_id = oc.order_id
    group by 
        oc.company_name
    having 
        sum(od.total_sales) > 1000
    order by 
        total_sales DESC
)

select 
    company_name,
    total_sales
from 
    sales_by_customers_UK
