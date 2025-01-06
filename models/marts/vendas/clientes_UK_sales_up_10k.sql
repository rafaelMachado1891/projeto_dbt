with customers_uk as (
    select 
        a.order_id,
        a.customer_id,
        b.company_name,
        b.country
    from {{ ref('int_orders') }} a 
    join 
    {{ ref("int_customers") }} b 
    on a.customer_id = b.customer_id
    where
    b.country = 'UK'
),
sales_by_customers as (
    select
     b.company_name,
     round(sum(a.total_sales),2) as total_sales
    from {{ref('int_order_details')}} a
    join
    customers_uk b 
    on b.order_id = a.order_id
    group by 
    b.company_name
    having
    sum(a.total_sales) > 1000
)

select * from sales_by_customers