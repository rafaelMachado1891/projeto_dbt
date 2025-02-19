with int_customers as (
    select 
     customer_id,
     company_name,
     country
    from {{ ref("stg_customers")}}
)

select
 customer_id,
 company_name,
 country
from int_customers