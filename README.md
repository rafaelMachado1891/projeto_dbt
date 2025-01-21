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

## Ferramentas Utilizadas

- **DBT Core**: Para modelagem, documentação e testes de dados.
- **PostgreSQL**: Banco de dados relacional utilizado para armazenar os dados transformados.
- **Render**: Serviço utilizado para hospedar o banco de dados.


