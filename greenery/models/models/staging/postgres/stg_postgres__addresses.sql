{{
  config(materialized = 'table')
}}

SELECT 
 address_id
 , address
 , state
 , lpad(zipcode,5,0) AS zip_code
 , country
FROM {{source('postgres','addresses')}}