{{
  config(materialized = 'table')
}}

WITH source AS (
SELECT * FROM {{source ('postgres','addresses')}}
)

, renamed_recast AS (
  SELECT
    address_id
    , address
    , state
    , lpad(zipcode,5,0) AS zip_code
    , country
    FROM source
 )

 SELECT 
 address_id
 , address
 , state
 , zip_code
 , country
 FROM renamed_recast