with int_products as (
    select
      product_id,
      product_name,
      category_id

    from {{ ref("stg_products") }}
)

select 
  product_id,
  product_name,
  category_id
from int_products