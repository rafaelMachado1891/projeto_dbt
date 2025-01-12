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

RECEITA_TOTAL AS (
SELECT
	 EXTRACT(YEAR FROM a.ORDER_DATE) AS ANO
	,EXTRACT(MONTH FROM a.ORDER_DATE) AS MES
	,SUM(total_sales) AS TOTAL    
FROM agregate_orders_by_order_detals a 
GROUP BY 
    EXTRACT(YEAR FROM a.ORDER_DATE),
    EXTRACT(MONTH FROM a.ORDER_DATE)
    ORDER BY 1,2
), 
RECEITASACUMULADAS AS (
	SELECT 
        ANO
        ,MES
        ,TOTAL
        ,SUM(TOTAL) OVER (PARTITION BY ANO ORDER BY MES) AS TOTALYTD
	FROM RECEITA_TOTAL
)
SELECT 
    ANO
    ,MES
    ,TOTAL
    ,TOTAL - LAG(TOTAL) OVER (PARTITION BY ANO ORDER BY MES) AS DIFERENCA_RECEITA
    ,TOTALYTD
    ,(TOTAL / (LAG(TOTAL) OVER (PARTITION BY ANO ORDER BY MES))-1) * 100 AS VARIACAO
FROM RECEITASACUMULADAS