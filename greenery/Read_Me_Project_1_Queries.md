Answers / Queries to Short

### Question 1 - How many users do we have?

SQL Query:
```
SELECT
COUNT(DISTINCT user_id)
FROM
dev_db.dbt_ameadinstaworkcom.sgt_postgres__users
```
ANSWER: 130

### Question 2 - On average, how many orders do we receive per hour?

SQL Query:
```
SELECT 
AVG(count_of_orders_per_hour) AS avg_orders_per_hour

FROM 
(
SELECT
 date_trunc('hour',created_at)
, COUNT(DISTINCT order_id) as count_of_orders_per_hour 
FROM dev_db.dbt_ameadinstaworkcom.stg_postgres__orders 
GROUP BY 1
)
```
ANSWER: 7.52

### Question 3 - On average, how long does an order take from being placed to being delivered?

SQL Query:
```
SELECT 
 ROUND(AVG(timediff(minute,created_at,delivered_at)),2) AS average_order_time_minutes
, ROUND(AVG(timediff(hour,created_at,delivered_at)),2) AS average_order_time_hours
, ROUND(AVG(timediff(day,created_at,delivered_at)),2) AS average_order_time_days
FROM dev_db.dbt_ameadinstaworkcom.stg_postgres__orders 
WHERE delivered_at IS NOT NULL
```
ANSWER: 5,604.2 Minutes; 93.4 Hours; 3.89 Days

### Question 4 - How many users have only made one purchase? Two purchases? Three+ purchases?

SQL Query:
```
SELECT
COUNT_IF(number_of_orders = 1) AS users_with_one
, COUNT_IF(number_of_orders = 2) AS users_with_two
, COUNT_IF(number_of_orders >=3) AS users_with_three_and_above
FROM
(
SELECT 
user_id
, COUNT(order_id) AS number_of_orders
FROM dev_db.dbt_ameadinstaworkcom.stg_postgres__orders 
GROUP BY 1
)
```
ANSWER: 25 users with only 1 purchase, 28 users with 2 purchases, 71 users with 3+ purchases

### Question 5 - On average, how many unique sessions do we have per hour?

SQL Query:
```
SELECT
AVG(unique_sessions) AS average_unique_sessions_per_hour
FROM
(
SELECT 
 date_trunc('hour',created_at) AS session_created_hour
, COUNT(DISTINCT session_id) AS unique_sessions
FROM dev_db.dbt_ameadinstaworkcom.stg_postgres__events 
GROUP BY 1
)
```
ANSWER: 16.33