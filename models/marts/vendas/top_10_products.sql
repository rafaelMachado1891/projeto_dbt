with products as (
    select
     product_id,
     product_name
    from {{ ref("int_products") }}
),

top_10_products_revenue as (
    select
     b.product_name,
     sum(a.total_sales) as total_sales
    from {{ ref('int_order_details') }} a 
    join products b 
     on b.product_id = a.product_id
    group by
     b.product_name
    order by 
    total_sales desc
    limit 10
)

select * from top_10_products_revenue