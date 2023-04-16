{{
  config(materialized = 'table')
}}

WITH source AS (
SELECT * FROM {{source ('postgres','promos')}}
)

, renamed_recast AS (
  SELECT
    promo_id
    , discount
    , status
    FROM source
 )

 SELECT 
 promo_id
 , discount
 , status
 FROM renamed_recast