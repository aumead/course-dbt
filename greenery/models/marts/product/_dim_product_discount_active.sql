SELECT
promo_id
, product_name
FROM {{ref('int_product_orders_agg')}}
WHERE promo_id IS NOT NULL
and status = 'Active'
