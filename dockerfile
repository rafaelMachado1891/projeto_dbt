# Usando uma imagem oficial do Python como base
FROM python:3.9

# Definir diretório de trabalho dentro do container
WORKDIR /app

# Copiar arquivos necessários
COPY requirements.txt .  
COPY northwind/ /app/northwind/
COPY dbt_project.yml profile.yml . 

# Instalar dependências
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install dbt-postgres 

# Definir o entrypoint padrão para rodar dbt
CMD ["dbt", "run", "--profiles-dir", "."]