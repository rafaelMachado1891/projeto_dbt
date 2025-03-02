# DBT Project: Northwind Analysis

## Descrição do Projeto

Este projeto utiliza o banco de dados Northwind como base para demonstrar a aplicação de técnicas de modelagem e análise de dados com o dbt (Data Build Tool). O objetivo é transformar e organizar os dados de maneira eficiente, disponibilizando-os em camadas estruturadas para consumo por equipes de análise e visualização.

## Estrutura do Projeto

O projeto foi organizado em camadas de modelagem no dbt, seguindo as melhores práticas para estruturação de dados:

1. **Camadas de Modelagem**:
   - **Staging (STG)**: Camada responsável por preparar os dados brutos, realizando pequenas limpezas e padronização. Alguns exemplos são (renomear colunas, selecionar ou deletar colunas)
   - **Intermediate (INT)**: Camada intermediária onde ocorrem transformações mais complexas e a criação de tabelas de junção.
   - **Marts (MRT)**: Camada final com tabelas e views prontas para consumo por ferramentas de análise e relatórios.

   
2. **Transformações e Consultas**:
   - As transformações foram desenvolvidas para atender às necessidades do negócio.
   - As consultas SQL criadas possibilitam responder a questões estratégicas de forma rápida e precisa.

3. **Relatórios**:
   - Os relatórios foram criados visando responder perguntas de negócios. A disponibilização das consultas foram feitas em fomato de views para facilitar a conexão com ferrametas de visualização de dados.

   - Questão 1: Qual foi o total de receitas para o ano de 1997? 

```sql
with orders as (
    select 
        order_id,
        order_date
    from 
        {{ ref("int_orders") }}
),
order_details as (
    select
        order_id,
        total_sales
    from {{ ref("int_order_details") }}
),
total_sales_1997 as (
    select
        sum(od.total_sales) as total_sales
    from order_details od
    join 
        orders o
    on 
        od.order_id = o.order_id
    where 
        extract(year from o.order_date) = 1997
)
select 
    total_sales
from total_sales_1997;
```

   - Questão 2: Qual é o total pago por cliente?

```sql
with orders as (
    select
        o.order_id,
        o.customer_id,
        c.company_name
    from 
        {{ ref("int_orders") }} o
    join 
        {{ ref("int_customers") }} c
    on 
        o.customer_id = c.customer_id
),
total_sales_by_customers as (
    select
        o.company_name,
        round(sum(od.total_sales), 2) as total_sales
    from 
        {{ ref("int_order_details") }} od
    join 
        orders o
    on 
        o.order_id = od.order_id
    group by 
        o.company_name
    order by 
        total_sales desc
)

select 
    company_name,
    total_sales
from 
    total_sales_by_customers
```

- Questão 3: Quais são os 10 produtos mais vendidos?

```sql
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
```

- Questão 4: Quais foram os clientes que compraram acima de 10 mil na região do Reino Unido?

```sql
with customers_UK as (
    select
        customer_id,
        company_name,
        country
    from 
        {{ ref('int_customers') }}
    where 
        country = 'UK'
),

orders as (
    select 
        order_id,
        customer_id
    from 
        {{ ref('int_orders') }}
),

orders_customer_UK as (
    select 
        c.customer_id,
        c.company_name,
        o.order_id
    from 
        customers_UK c
    join 
        orders o 
    on 
        c.customer_id = o.customer_id
),

order_details as (
    select
        order_id,
        sum(total_sales) as total_sales
    from 
        {{ ref('int_order_details') }}
    group by 
        order_id
),

sales_by_customers_UK as (
    select
        oc.company_name,
        round(sum(od.total_sales), 2) as total_sales
    from 
        order_details od
    join 
        orders_customer_UK oc
    on 
        od.order_id = oc.order_id
    group by 
        oc.company_name
    having 
        sum(od.total_sales) > 1000
    order by 
        total_sales DESC
)

select 
    company_name,
    total_sales
from 
    sales_by_customers_UK
```

- Questão 5: Agrupe os clientes em 5 grupos de acordo com o pagamento

```sql
with order_details as (
    select 
     order_id,
     total_sales
    from {{ ref("int_order_details") }}
),

orders as ( 
    select 
     order_id,
     customer_id
    from {{ ref('int_orders') }}
),

customers as (
    select 
     customer_id,
     company_name
    from {{ ref('int_customers')}}
),

agregate_orders_by_orders_details as (
    select
     c.company_name,
     a.total_sales
    from order_details a
    join orders b
    on b.order_id = a.order_id
    join customers c
    on c.customer_id = b.customer_id
),

customers_by_group as (
    select
        company_name,
        round(sum(total_sales), 2)  as total_sales,
        NTILE(5) OVER (ORDER BY sum(total_sales) DESC) AS customer_group
    from agregate_orders_by_orders_details
    group by
        company_name
    order by 2 DESC
)

select * 
from customers_by_group
```

- Questão 6: Quais são os clientes dos grupos 3,4 e 5? 

```sql
with order_details as (
    select 
     order_id,
     total_sales
    from {{ ref("int_order_details") }}
),

orders as ( 
    select 
     order_id,
     customer_id
    from {{ ref('int_orders') }}
),

customers as (
    select 
     customer_id,
     company_name
    from {{ ref('int_customers')}}
),

agregate_orders_by_orders_details as (
    select
     c.company_name,
     a.total_sales
    from order_details a
    join orders b
    on b.order_id = a.order_id
    join customers c
    on c.customer_id = b.customer_id
),

customers_by_group as (
    select
        company_name,
        round(sum(total_sales), 2)  as total_sales,
        NTILE(5) OVER (ORDER BY sum(total_sales) DESC) AS customer_group
    from agregate_orders_by_orders_details
    group by
        company_name
    order by 2 DESC
)


select * 
from customers_by_group
where
customer_group in (3,4,5)
```

- Questão 7: Quais são os clientes dos grupos 3,4 e 5? 

```sql
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
```


## Ferramentas Utilizadas

- **DBT Core**: Para modelagem, documentação e testes de dados.
- **PostgreSQL**: Banco de dados relacional utilizado para armazenar os dados transformados.
- **Render**: Serviço utilizado para hospedar o banco de dados.


