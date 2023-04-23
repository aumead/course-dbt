SELECT
date_trunc('day',created_at) as day
, product_id
, product_name
, COUNT(DISTINCT order_id) AS number_of_orders
FROM {{ref('int_product_orders_agg')}}
GROUP BY 1,2,3
ORDER BY 1 DESC