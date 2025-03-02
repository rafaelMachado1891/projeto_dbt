# Usa a imagem oficial do Python Slim
FROM python:3.12.4-slim  

# Instala dependências básicas + postgresql-client
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho como /app
WORKDIR /app  

# Copia apenas os arquivos essenciais primeiro (para melhor cache)
COPY requirements.txt .  

# Instala dependências do dbt
RUN pip install --no-cache-dir -r requirements.txt  

# Copia o restante do projeto
COPY . .  

# Define a pasta do projeto dbt como diretório de trabalho
WORKDIR /app/northwind  

# Adiciona um script de espera para garantir que o banco esteja pronto
COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh  

# Define o comando para rodar dbt dentro da pasta correta após aguardar o PostgreSQL
CMD ["/wait-for-it.sh", "db", "5432", "--", "dbt", "run"]