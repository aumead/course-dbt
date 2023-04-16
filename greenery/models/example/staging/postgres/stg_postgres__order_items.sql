{{
  config(materialized = 'table')
}}

WITH source AS (
SELECT * FROM {{source ('postgres','order_items')}}
)

, renamed_recast AS (
  SELECT
    order_id
    , product_id
    , quantity
    FROM source
 )

 SELECT 
 order_id
 , product_id
 , quantity
 FROM renamed_recast