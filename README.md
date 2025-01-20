# DBT Project: Northwind Analysis

## Descrição do Projeto

Este projeto utiliza o banco de dados Northwind como base para demonstrar a aplicação de técnicas de modelagem e análise de dados com o dbt (Data Build Tool). Seu objetivo é estruturar e transformar os dados de maneira eficiente, facilitando a resposta a questões de negócios estratégicas.

## Estrutura do Projeto

O projeto foi dividido nas seguintes etapas:

1. **Configuração do Banco de Dados**:
   - O banco de dados Northwind foi migrado para o PostgreSQL.
   - A instância do banco foi hospedada na nuvem utilizando o Render.

2. **Camadas de Modelagem**:
   - **Staging**: Camada de preparação dos dados brutos para limpeza e padronização.
   - **Intermediate**: Camada intermediária para transformações mais complexas e criação de tabelas de junção.
   - **Marts**: Camada final com tabelas prontas para consumo por ferramentas de análise e visualização.

3. **Transformações e Consultas**:
   - Foram realizadas transformações para atender aos requisitos de negócio.
   - Consultas SQL foram criadas para responder a perguntas de negócios específicas.

## Ferramentas Utilizadas

- **DBT Core**: Para modelagem, documentação e testes de dados.
- **PostgreSQL**: Banco de dados relacional utilizado para armazenar os dados.
- **Render**: Serviço de hospedagem na nuvem para o banco de dados.

## Como Reproduzir o Projeto

1. Clone o repositório:
   ```bash
   git clone <link-do-repositorio>
