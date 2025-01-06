with int_customers as ( 
    select
        customer_id,
        company_name,
        contact_name,
        country
    from {{ref ("stg_customers") }}
    
)

select * from int_customers