

with total_sales_by_customers as (
    select
     company_name,
     round(sum(total_sales), 2)  as total_sales
    from {{ ref("int_order_details") }}
    group by 
    company_name
    order by 
    total_sales
    desc 

)

select * from total_sales_by_customers