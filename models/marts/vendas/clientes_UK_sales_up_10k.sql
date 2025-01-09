with sales_by_customers_Uk as (
    select
     company_name,
     round(sum(total_sales),2) as total_sales
    from {{ref('int_order_details')}}
    where
    country = 'UK'
    group by 
    company_name
    having
    sum(total_sales) > 1000
    order by
    total_sales DESC
)

select * from sales_by_customers_Uk