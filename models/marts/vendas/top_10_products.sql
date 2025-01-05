with

products as (
    select * from {{ ref ("int_products_select_columns") }}
),

order_details as (
    select * from {{ ref("int_order_details") }}
),
top_10_products_revenue as (
    select
     products.product_name,
     sum(unit_price * quantity * (1- discount)) as total_sales
    from order_details
    join
    products on products.product_id = order_details.product_id
    group by
     products.product_name
    order by 
    total_sales desc
    limit 10
)

select * from top_10_products_revenue