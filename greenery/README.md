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



## Week 3

#### What is our overall conversion rate?

Overal conversion rate is 62.456700%

```
SELECT 
    COUNT(DISTINCT session_uuid)                   AS total_sessions, 
    COUNT(DISTINCT order_uuid)                     AS session_with_purchase,
    session_with_purchase/total_sessions * 100     AS conversion_rate
FROM DEV_DB.DBT_LISKJ94.fct_conversions;
```
#### What is our conversion rate by product?

```
SELECT 
    product_uuid                                   AS product,
    COUNT(DISTINCT session_uuid)                   AS total_sessions, 
    COUNT(DISTINCT order_uuid)                     AS session_with_purchase,
    session_with_purchase/total_sessions * 100     AS conversion_rate
FROM DEV_DB.DBT_LISKJ94.fct_conversions
GROUP BY 1;
```

| PRODUCT                              | TOTAL_SESSIONS | SESSION_WITH_PURCHASE | CONVERSION_RATE |
|--------------------------------------|----------------|-----------------------|-----------------|
| c7050c3b-a898-424d-8d98-ab0aaad7bef4 | 34             | 34                    | 100             |
| e18f33a6-b89a-4fbc-82ad-ccba5bb261cc | 28             | 28                    | 100             |
| 80eda933-749d-4fc6-91d5-613d29eb126f | 31             | 31                    | 100             |
| 689fb64e-a4a2-45c5-b9f2-480c2155624d | 36             | 36                    | 100             |
| bb19d194-e1bd-4358-819e-cd1f1b401c0c | 33             | 33                    | 100             |
| 4cda01b9-62e2-46c5-830f-b7f262a58fb1 | 21             | 21                    | 100             |
| 843b6553-dc6a-4fc4-bceb-02cd39af0168 | 29             | 29                    | 100             |
| e8b6528e-a830-4d03-a027-473b411c7f02 | 29             | 29                    | 100             |
| e706ab70-b396-4d30-a6b2-a1ccf3625b52 | 28             | 28                    | 100             |
| 6f3a3072-a24d-4d11-9cef-25b0b5f8a4af | 21             | 21                    | 100             |
| 37e0062f-bd15-4c3e-b272-558a86d90598 | 29             | 29                    | 100             |
| e2e78dfc-f25c-4fec-a002-8e280d61a2f2 | 26             | 26                    | 100             |
| 74aeb414-e3dd-4e8a-beef-0fa45225214d | 35             | 35                    | 100             |
| 05df0866-1a66-41d8-9ed7-e2bbcddd6a3d | 27             | 27                    | 100             |
| be49171b-9f72-4fc9-bf7a-9a52e259836b | 25             | 25                    | 100             |
| 5b50b820-1d0a-4231-9422-75e7f6b0cecf | 28             | 28                    | 100             |
| 35550082-a52d-4301-8f06-05b30f6f3616 | 22             | 22                    | 100             |
| a88a23ef-679c-4743-b151-dc7722040d8c | 22             | 22                    | 100             |
| 5ceddd13-cf00-481f-9285-8340ab95d06d | 33             | 33                    | 100             |
| c17e63f7-0d28-4a95-8248-b01ea354840e | 30             | 30                    | 100             |
| 579f4cd0-1f45-49d2-af55-9ab2b72c3b35 | 28             | 28                    | 100             |
| NULL                                 | 578            | 0                     | 0               |
| 615695d3-8ffd-4850-bcf7-944cf6d3685b | 32             | 32                    | 100             |
| d3e228db-8ca5-42ad-bb0a-2148e876cc59 | 26             | 26                    | 100             |
| b66a7143-c18a-43bb-b5dc-06bb5d1d3160 | 34             | 34                    | 100             |
| 55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3 | 30             | 30                    | 100             |
| 64d39754-03e4-4fa0-b1ea-5f4293315f67 | 28             | 28                    | 100             |
| e5ee99b6-519f-4218-8b41-62f48f59f700 | 27             | 27                    | 100             |
| 58b575f2-2192-4a53-9d21-df9a0c14fc25 | 24             | 24                    | 100             |
| fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80 | 39             | 39                    | 100             |
| b86ae24b-6f59-47e8-8adc-b17d88cbd367 | 27             | 27                    | 100             |

#### Create a macro to simplify part of a model(s)

Created a macro to calculate the session_length 

#### Add a post hook to your project to apply grants to the role “reporting”. 

#### Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project

I have used dbt-utils surrogate_key and group_by

#### DAG 



#### Run the orders snapshot model using dbt snapshot and query it in snowflake to see how the data has changed since last week. Which orders changed from week 2 to week 3? 

I ran the following query to find the changed orders:

```
SELECT * FROM DEV_DB.DBT_LISKJ94.SNAPSHOT_ORDERS
WHERE dbt_valid_to IS NOT NULL;
```

<img width="2073" alt="image" src="https://user-images.githubusercontent.com/20020382/198836290-c17dcdc4-c1a5-4e9a-8879-f530531be349.png">



