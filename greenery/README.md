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
WITH purchase_amount AS (

    SELECT 
        user_uuid,
        CASE WHEN count(DISTINCT order_uuid) < 2 THEN 'purchased_once'
             ELSE 'multiple_purchases'
        END AS purchase_amount
    FROM DEV_DB.DBT_LISKJ94.STG_GREENERY__ORDERS
    GROUP BY 1
    
), 

total AS(

    SELECT 
        COUNT(purchase_amount) AS total, 
        COUNT(CASE purchase_amount WHEN 'multiple_purchases' THEN 1 ELSE NULL END) AS total_multiple_purchases
    FROM purchase_amount
)
    
SELECT 
    div0(total_multiple_purchases,total) AS repeat_rate 
FROM TOTAL;
```

#### What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

I'd look into which products are popular amongst users who purchase multiple times and use that as an indicator for users who are likely to purchase again. We could also look into number of sessions, money spent on purchases, number of items purchased, and delivery time. 

I'd love to know more about customers' satisfaction with our product and customer service. 


#### Models

I organized my models in 2 layers: Intermediate and dim/fact tables. I did most of the data transformation in my intermediate tables which I then used to create my dims and facts. 

#### DAG


<img width="1455" alt="Screen Shot 2022-10-17 at 16 26 25" src="https://user-images.githubusercontent.com/20020382/196301970-9f83a9e1-6eff-427f-bf78-dee34e9d8d5d.png">

### Tests

#### What assumptions are you making about each model? (i.e. why are you adding each test?)

I assumed that the primary key of each table should never be null. 

Depending on the table, I made different assumptions. I assumed that addresses should be not null, at least the address and the country.

All the created_at fields should be not null as we need to know when the records were created in all tables.

#### Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

I had to adjust my assumptions about the uuid in many of the models. I thought they would be unique but I realised that depending on the table I am dealing with, there are duplicated uuids. I added/removed tests after they failed and I realised my mistake.

#### Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

We need to run a scheduled job daily for each model to ensure bad data is not being added to our models. If we notice something is wrong with the data, we should first ensure that our logic in how we model our tables isn't causing the bad data. We can usually test whether the bad data is present in the source models, which should tell us that there is an issue with the data extraction or loading.

#### Snapshot

```
SELECT * FROM DEV_DB.DBT_LISKJ94.SNAPSHOT_ORDERS
WHERE dbt_valid_to IS NOT NULL;
```

<img width="2071" alt="image" src="https://user-images.githubusercontent.com/20020382/196598792-c4896890-5aa0-43a9-9864-75a98a92630f.png">



