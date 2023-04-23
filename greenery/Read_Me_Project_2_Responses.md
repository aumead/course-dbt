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
- I'm also assuming that an order that is placed has to also have some value (i.e., volume of an order is not null) otherwise we may be encountering a data error
- Lastly, I assume that each order has its own unique identifier

### Did you find any "bad" data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
- I did not encounter any "bad" data as I ran tests on my models
- If I did run into an issue with bad data, though, we'd have to work with the engineering team behind the failed source data to uncover the root issue and then decide what to do moving forward (e.g., if we see an order_total being null, adding string text of "free" for the order)

### Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
Setup freshness tests to ensure that sources are as up to date as expected (work with stakeholders on defining the right amount of time a source is updated).

If bad data continues to get through, there are likely further tests that can be created to mitigate these instances. There would also likely need to be a conversation with the engineering team to identify the root issue of why bad data still flows into our sources.

## Part 3 - Snapshot
### Which products had their inventory change from week 1 to week 2?
SQL Query:
```
SELECT * 
FROM dev_db.dbt_ameadinstaworkcom.products_snapshot
WHERE dbt_valid_to IS NOT NULL
```
Answer: Pothos, Philodendron, Monstera, String of pearls