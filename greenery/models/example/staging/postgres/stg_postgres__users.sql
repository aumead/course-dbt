{{
  config(materialized = 'table')
}}

WITH source AS (
SELECT * FROM {{source ('postgres','users')}}
)

, renamed_recast AS (
  SELECT
    user_id
    , first_name
    , last_name
    , email
    , phone_number
    , created_at
    , updated_at
    , address_id
    FROM source
 )

 SELECT 
 user_id
 , first_name
 , last_name
 , email
 , phone_number
 , created_at
 , updated_at
 , address_id
 FROM renamed_recast