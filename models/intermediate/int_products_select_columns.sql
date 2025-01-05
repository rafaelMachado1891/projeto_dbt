with int_products_select_columns as (
    select
     product_id,
     product_name,
     category_id
    from {{ ref("stg_products") }}
)

select * from int_products_select_columns