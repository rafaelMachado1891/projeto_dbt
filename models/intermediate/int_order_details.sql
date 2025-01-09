with int_orders_details_select_columns as (
    select
     a.order_id,
     b.customer_id,
     c.company_name,
     c.country,
     b.employee_id,
     b.order_date,
     a.product_id,
     d.product_name,
     cast(a.unit_price as decimal) as unit_price,
     cast(a.quantity as int) as quantity,
     cast(a.discount as decimal) discount,
     cast(sum(a.unit_price * a.quantity * (1-a.discount))as decimal) as total_sales
    from 
    {{ ref("stg_order_details")}} a 
    join
    {{ ref('stg_orders')}} b 
    on b.order_id = a.order_id
    join
    {{ ref('stg_customers') }} c 
    on c.customer_id = b.customer_id
    join
    {{ ref('stg_products')}} d
    on d.product_id = a.product_id
    group by
    a.order_id,
    a.product_id,
    a.unit_price,
    a.quantity,
    a.discount,
    b.customer_id,
    b.employee_id,
    b.order_date,
    c.company_name,
    d.product_name,
    c.country

)
 select * from int_orders_details_select_columns