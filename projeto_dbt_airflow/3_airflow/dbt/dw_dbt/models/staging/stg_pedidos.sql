with source as (
    select * from {{ ref('pedidos') }}
),

transformado as (
    select
        -- Chaves
        id_pedido,
        cpf,
        
        -- Valores monetários
        valor_pedido,
        
        
        -- Status e datas
        data_pedido as dt_pedido,
        
        -- Metadados
        current_timestamp as etl_inserted_at
        
    from source
)

select * from transformado