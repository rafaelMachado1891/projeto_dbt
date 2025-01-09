with total_sales_1997 as (
    select
    round(sum(total_sales), 2)  as total_sales
    from {{ ref("int_order_details") }}
    where
    extract(year from order_date) = 1997
)

select * from total_sales_1997