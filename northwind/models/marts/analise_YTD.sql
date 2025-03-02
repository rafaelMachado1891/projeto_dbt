WITH order_details as (
    select 
      order_id,
      total_sales
    from {{ ref('int_order_details') }}

),

orders as (
    select 
     order_id,
     order_date
    from {{ ref('int_orders') }}
),

agregate_orders_by_order_detals as (
    select
     o.order_id,
     o.order_date,
     sum(od.total_sales) total_sales
    from orders o
    join order_details od
    on o.order_id = od.order_id
    group by 
    o.order_id,
    o.order_date
),

revenue_total as (
select
	 EXTRACT(year from a.order_date) as ano
	,EXTRACT(month from a.order_date) as mes
	,sum(total_sales) AS total    
from agregate_orders_by_order_detals a 
group by
    EXTRACT(year from a.order_date),
    EXTRACT(month from a.order_date)
    order by 1,2
),  
accumulated_revenue as (
	select
         ano
        ,mes
        ,total
        ,sum(total) over (partition by ano order by mes) as totalytd
	from revenue_total
)
select
     ano
    ,mes
    ,total
    ,total - lag(total) over(partition by ano order by mes) as diferenca_receita
    ,totalytd
    ,(total / lag(total) over (partition by ano order by mes))-1* 100 as variacao
from accumulated_revenue