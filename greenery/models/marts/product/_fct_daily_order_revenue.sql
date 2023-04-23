SELECT 
date_trunc('day',created_at) AS day
, product_id
, product_name
, SUM(order_total) AS order_total
FROM {{ref('int_product_orders_agg')}}
GROUP BY 1,2,3
ORDER BY 1 DESC