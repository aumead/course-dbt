{{
  config(materialized = 'table')
}}

SELECT
o.order_id 
, o.promo_id
, o.user_id 
, o.address_id 
, o.created_at as created_at
, o.order_cost
, o.shipping_cost
, o.order_total AS order_total
, o.estimated_delivery_at
, o.delivered_at
, o.status as order_status
, oi.product_id as product_id
, oi.quantity
, p.name as product_name
, p.price
, p.inventory
, pr.discount
, pr.status
FROM {{ref('stg_postgres__orders')}} o
LEFT JOIN {{ref('stg_postgres__order_items')}} oi 
    ON o.order_id = oi.order_id 
LEFT JOIN {{ref('stg_postgres__products')}} p 
    ON oi.product_id = p.product_id
LEFT JOIN {{ref('stg_postgres__promos')}} pr
    ON o.promo_id = pr.promo_id