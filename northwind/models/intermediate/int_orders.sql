with int_orders as (
    select
        order_id,
        customer_id,
        employee_id,
        order_date

    from {{ ref('stg_orders') }}
)

select
  order_id,
  customer_id,
  employee_id,
  order_date
from int_orders