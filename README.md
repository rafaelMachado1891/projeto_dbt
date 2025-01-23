# DBT Project: Northwind Analysis

## Descrição do Projeto

Este projeto utiliza o banco de dados Northwind como base para demonstrar a aplicação de técnicas de modelagem e análise de dados com o dbt (Data Build Tool). O objetivo é transformar e organizar os dados de maneira eficiente, disponibilizando-os em camadas estruturadas para consumo por equipes de análise e visualização.

## Estrutura do Projeto

O projeto foi organizado em camadas de modelagem no dbt, seguindo as melhores práticas para estruturação de dados:

1. **Camadas de Modelagem**:
   - **Staging (STG)**: Camada responsável por preparar os dados brutos, realizando limpeza e padronização.
   - **Intermediate (INT)**: Camada intermediária onde ocorrem transformações mais complexas e a criação de tabelas de junção.
   - **Marts (MRT)**: Camada final com tabelas e views prontas para consumo por ferramentas de análise e relatórios.

   ![Projeto](.pics/pngdbtcore.png)

2. **Transformações e Consultas**:
   - As transformações foram desenvolvidas para atender às necessidades do negócio.
   - As consultas SQL criadas possibilitam responder a questões estratégicas de forma rápida e precisa.

3. **Relatórios**:
   - Os relatórios foram criados visando responder perguntas de negócios. A disponibilização das consultas foram feitas em fomato de views para facilitar a conexão com ferrametas de visualização de dados.

   - Questão 1: Qual foi o total de receitas para o ano de 1997? 

   ```with orders as (
    select 
        order_id,
        order_date
    from 
        {{ ref("int_orders") }}
)
order_details as (
    select
        order_id,
        total_sales
    from 
        {{ ref("int_order_details") }}
)
total_sales_1997 as (
    select
        sum(od.total_sales) as total_sales
    from 
        order_details od
    join 
        orders o
    on 
        od.order_id = o.order_id
    where 
        extract(year from o.order_date) = 1997
)
select 
    total_sales
from 
    total_sales_1997;
```



## Ferramentas Utilizadas

- **DBT Core**: Para modelagem, documentação e testes de dados.
- **PostgreSQL**: Banco de dados relacional utilizado para armazenar os dados transformados.
- **Render**: Serviço utilizado para hospedar o banco de dados.


