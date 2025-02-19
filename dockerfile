# Usa a imagem oficial do Python Slim para reduzir o tamanho
FROM python:3.12.4-slim  

# Define o diretório de trabalho como /app
WORKDIR /app  

# Copia todo o conteúdo do projeto para a imagem
COPY . /app  

# Instala dependências do dbt
RUN pip install -r requirements.txt  

# Define a pasta do projeto dbt como diretório de trabalho
WORKDIR /app/northwind  

# Define o comando para rodar dbt dentro da pasta correta
CMD ["dbt", "run"]