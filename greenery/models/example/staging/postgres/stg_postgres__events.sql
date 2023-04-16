{{
  config(materialized = 'table')
}}

WITH source AS (
SELECT * FROM {{source ('postgres','events')}}
)

, renamed_recast AS (
  SELECT
    event_id
    , session_id
    , user_id
    , event_type
    , page_url
    , created_at
    , order_id
    , product_id
    FROM source
 )

 SELECT 
 event_id
 , session_id
 , user_id
 , event_type
 , page_url
 , created_at
 , order_id
 , product_id
 FROM renamed_recast