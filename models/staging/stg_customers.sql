whit source as (

    SELECT * FROM {{ source('northwind_ne7m', 'customer') }}

)

SELECT 
     customer_id
    ,company_name
FROM source
