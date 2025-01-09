with customers_by_group as (
    select
        company_name,
        round(sum(total_sales), 2)  as total_sales,
        NTILE(5) OVER (ORDER BY sum(quantity * unit_price * (1 - discount)) DESC) AS customer_group
    from {{ ref("int_order_details")}}
    group by
        company_name
    order by 2 DESC
)

select * 
from customers_by_group
