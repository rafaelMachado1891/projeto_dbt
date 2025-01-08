select * from {{ source('northwind_ne7m', 'orders') }}
