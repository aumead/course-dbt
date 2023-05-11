## Part 1
### What is our overall conversion rate?

SQL Query:
```
with session_counts as
(
    select
        count(distinct event_session_checkout) as purchase_sessions
        , count(distinct event_session_guid) as total_sessions
    from _fct_conversion_rate
)

select
    (purchase_sessions / total_sessions) * 100 as conversion_rate

from session_counts;

```
ANSWER: 62.46%

### What is our conversion rate by product?
SQL Query:
```
with session_counts_product as (
    select
        product_name,
        count(distinct event_session_checkout) as purchase_sessions,
        count(distinct event_session_guid) as total_sessions
    from _fct_conversion_rate
    where product_name is not null
    group by 1
)

select
    product_name,
    (purchase_sessions / total_sessions) * 100 as conversion_rate
from session_counts_product
order by 1 desc;
```

## Part 6
### Which products had their inventory change from week 2 to week 3?
SQL Query:
```
with last_update as
(
    select 
        max(dbt_valid_from) as latest_date
        from dev_db.dbt_ameadinstaworkcom.products_snapshot
) 
select distinct(name)
from dev_db.dbt_ameadinstaworkcom.products_snapshot
WHERE dbt_valid_to IS NULL
and dbt_valid_from = max_date
```
Answer:
- Monstera
- Pothos
- Philodendron
- ZZ Plant
