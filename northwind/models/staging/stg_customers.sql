select * from {{ source('postgres', 'customers') }}
