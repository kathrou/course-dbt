## Week 1

#### How many users do we have?

130

#### On average, how many orders do we receive per hour?

7.5 orders per hour

#### On average, how long does an order take from being placed to being delivered?

93.4 hours

####  How many users have only made one purchase? Two purchases? Three+ purchases?

- 1 purchase: 25
- 2 purchases: 28
- 3+  purchases: 71

#### On average, how many unique sessions do we have per hour?

16 sessions per hour on average


## Week 2

#### What is our user repeat rate?
_Repeat Rate = Users who purchased 2 or more times / users who purchased_

```
WITH purchase_amount AS(
    SELECT 
        user_uuid,
        CASE WHEN count(DISTINCT order_uuid) < 2 THEN 'purchased_once'
             ELSE 'multiple_purchases'
        END AS purchase_amount
    FROM DEV_DB.DBT_LISKJ94.STG_GREENERY__ORDERS
    GROUP BY 1
), total AS(

    SELECT COUNT(purchase_amount) AS total, 
           COUNT(CASE purchase_amount WHEN 'multiple_purchases' THEN 1 ELSE NULL END) AS total_multiple_purchases
    FROM purchase_amount
)
    
SELECT div0(total_multiple_purchases,total) AS repeat_rate FROM TOTAL;
```
