with top_10_products_revenue as (
    select
     product_name,
     sum(unit_price * quantity * (1- discount)) as total_sales
    from {{ ref('int_order_details') }}
    group by
     product_name
    order by 
    total_sales desc
    limit 10
)

select * from top_10_products_revenue