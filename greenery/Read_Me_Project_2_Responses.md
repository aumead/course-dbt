## Part 1 - Models
### What is our user repeat rate?

SQL Query:

```
SELECT 
users_with_two_and_above / (users_with_one + users_with_two_and_above)
FROM 
(
SELECT
COUNT_IF(number_of_orders = 1) AS users_with_one
, COUNT_IF(number_of_orders >= 2) AS users_with_two_and_above
FROM
(
SELECT 
user_id
, COUNT(order_id) AS number_of_orders
FROM dev_db.dbt_ameadinstaworkcom.stg_postgres__orders 
GROUP BY 1
)
)

```
ANSWER: 79.84%

### What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

**Indicators of a user who will likely purchase again**
- A user has purchased more than once in the past
- A user that has recently purchased more than once in the past
- Users that purchase a product that has been purchased multiple times by a single user over a period of time
- User signs up for membership / rewards program
- User exclusively uses Greenery for their purchases

**Indicators of a user who will likely not purchase again**
- A user has not purchased more than once in the past
- A user's last order date was more than a year ago
- A user purchases a product that isn't normally purchased multiple times over a given period of time
- User is not a part of the membership / rewards program
- User does not exclusively use Greenery for their purchases

**If you had more data, what features would you want to look into to answer this question?**
- Do we currently have a customer loyalty program? If so, what discounts / exclusive benefits do we offer our customers and do these discounts encourage repeat behavior (assuming repeat behavior is the desired outcome)?
- External customer behavior (maybe captured via survey) - if customers do not purchase from us, where are they shopping?
- Customer engagement survey - what unique attributes of our store keep customers purchasing from us? Customer service, low prices?

### Explain the product mart models you added? Why did you organize the models in the way you did?
- I created an intermediary moodel that aggregated the orders, order items, product id and promo code tables
- Within from this intermediary model, I created 2 fact tables (daily order revenue by product name & daily volume of orders by product name) and 1 dim table (active product discounts)
- I created these models to help the product team better understand our most successful products (in terms of quantity and revenue)
- By aggregating the tables into an intermediary model, I made it easier to arrive at tables that would be most useful for a product manager to use; it is now easier to self serve based off of the int models

## Part 2 - Tests
### What assumptions are you making about each model? (i.e., why are you adding each test?)
- I added the following tests to my models
    - order_total not null
    - count_of_orders not null
    - unique order id
- I'm assuming that an order that is placed has some value (i.e., costs a specific amount) otherwise we may be encountering a data error
- I'm also assuming that each order id is unique