

with total_sales_by_customers as (
    select
     int_customers.company_name,
     round(sum(int_order_details.total_sales), 2)  as total_sales
    from {{ ref("int_orders")}}

    join 
    {{ ref("int_customers") }}
    on int_orders.customer_id = int_customers.customer_id
    join 
    {{ ref("int_order_details")}}
    on int_orders.order_id = int_order_details.order_id
    group by 
    int_customers.company_name
    order by 
    total_sales
    desc 

)

select * from total_sales_by_customers