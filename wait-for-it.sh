#!/bin/bash
# Espera até que o banco esteja pronto

host="$1"
port="$2"
shift 2
cmd="$@"

echo "Esperando conexão com o banco em $host:$port..."

while ! pg_isready -h "$host" -p "$port" > /dev/null 2>&1; do
    echo "Banco de dados não está pronto ainda..."
    sleep 2
done

echo "Banco de dados pronto! Executando comando..."
exec $cmd