{{
  config(materialized = 'table')
}}

WITH source AS (
SELECT * FROM {{source ('postgres','products')}}
)

, renamed_recast AS (
  SELECT
    product_id
    , name
    , price
    , inventory
    FROM source
 )

 SELECT 
 product_id
 , name
 , price
 , inventory
 FROM renamed_recast