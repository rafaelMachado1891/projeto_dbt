with int_customers as ( 
    select
        customer_id,
        contact_name,
        country
    from {{ref ("stg_customers") }}
    
)

select * from int_customers