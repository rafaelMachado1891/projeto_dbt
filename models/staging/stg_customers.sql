whit source as (

    SELECT * FROM {{ source(northwind_ne7m, customers) }}

)

SELECT 
     customer_id
    ,company_name
FROM source


