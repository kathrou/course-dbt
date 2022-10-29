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

| ORDER_ID                             | USER_ID                              | PROMO_ID  | ADDRESS_ID                           | CREATED_AT          | ORDER_COST | SHIPPING_COST | ORDER_TOTAL | TRACKING_ID | SHIPPING_SERVICE | ESTIMATED_DELIVERY_AT | DELIVERED_AT | STATUS    | DBT_SCD_ID                       | DBT_UPDATED_AT      | DBT_VALID_FROM      | DBT_VALID_TO        |
|--------------------------------------|--------------------------------------|-----------|--------------------------------------|---------------------|------------|---------------|-------------|-------------|------------------|-----------------------|--------------|-----------|----------------------------------|---------------------|---------------------|---------------------|
| 8385cfcd-2b3f-443a-a676-9756f7eb5404 | 96aa719e-c5a3-4645-ba89-16c304fb59b0 |           | 1ceb9167-9852-45a7-8109-57b077d8a2e0 | 2021-02-11 02:19:17 | 205.5      | 1.44          | 206.94      |             |                  |                       |              | preparing | 0ffc02d3885fec87228bbfbd69d649df | 2022-10-09 20:19:59 | 2022-10-09 20:19:59 | 2022-10-29 14:07:17 |
| e24985f3-2fb3-456e-a1aa-aaf88f490d70 | b9287f6c-c865-49bb-a3c9-da47bbdf3a90 |           | 027e0a9d-2bb0-4247-8989-365339741a93 | 2021-02-11 10:11:14 | 256.25     | 7.94          | 264.19      |             |                  |                       |              | preparing | a8fd79a17d70f73109a4736a6b4de3b5 | 2022-10-09 20:19:59 | 2022-10-09 20:19:59 | 2022-10-29 14:07:17 |
| 38c516e8-b23a-493a-8a5c-bf7b2b9ea995 | 96ca8e55-2cbd-4c9b-9540-ff0ac6309797 | Mandatory | 0314fc1b-d832-4562-bda4-7dbe09d2868c | 2021-02-11 16:11:14 | 213.85     | 8.88          | 202.73      |             |                  |                       |              | preparing | 6e986492ba444bbeb420a1da097aeda2 | 2022-10-09 20:19:59 | 2022-10-09 20:19:59 | 2022-10-29 14:07:17 |
| 5741e351-3124-4de7-9dff-01a448e7dfd4 | bbe518c7-5ea8-444e-acef-6c18be8336bc |           | f2dfb1e6-43bf-49ac-8d17-e1498079e08b | 2021-02-11 18:11:14 | 462        | 8.05          | 470.05      |             |                  |                       |              | preparing | 3314326aa150e0f9eb028bbb03b3b060 | 2022-10-09 20:19:59 | 2022-10-09 20:19:59 | 2022-10-29 14:07:17 |
| d1020671-7cdf-493c-b008-c48535415611 | 1df78ad9-9493-4ce9-b1ad-776f26650417 |           | 48ee18eb-8ee7-4cd7-819b-a9c65184e4ac | 2021-02-11 04:51:15 | 161        | 6.55          | 167.55      |             |                  |                       |              | preparing | 1cb3aed621551984adf1b4f8aa4ff8e0 | 2022-10-09 20:19:59 | 2022-10-09 20:19:59 | 2022-10-29 14:07:17 |
| aafb9fbd-56e1-4dcc-b6b2-a3fd91381bb6 | e879df28-ff9c-4900-b99c-c769ec349316 |           | 959fc946-4baf-457f-8290-2a7d0e7fc3f7 | 2021-02-11 11:44:42 | 45         | 5.13          | 50.13       |             |                  |                       |              | preparing | bb2c9de3a8e8d77f2102073735e876e4 | 2022-10-09 20:19:59 | 2022-10-09 20:19:59 | 2022-10-29 14:07:17 |
| 914b8929-e04a-40f8-86ee-357f2be3a2a2 | 6aff561d-fbd9-4130-8242-8b9073cc3a03 |           | b3db1ec9-17b7-4b15-8f04-b2077048f428 | 2021-02-11 20:54:54 | 50         | 6.23          | 56.23       |             |                  |                       |              | preparing | 695f0357d16e6931fdd29872022648dc | 2022-10-09 20:19:59 | 2022-10-09 20:19:59 | 2022-10-17 23:28:41 |
| 05202733-0e17-4726-97c2-0520c024ab85 | 5951d1d2-614e-4557-a2de-8298a1e4b179 |           | 3a286955-76c1-4b50-b5fc-61e4e4e3be4d | 2021-02-11 05:29:28 | 441        | 9.71          | 450.71      |             |                  |                       |              | preparing | f9af2ccb812a9f8c505fb789332b68d5 | 2022-10-09 20:19:59 | 2022-10-09 20:19:59 | 2022-10-17 23:28:41 |
| 939767ac-357a-4bec-91f8-a7b25edd46c9 | 6cf2751f-d815-4fbc-b04a-245c1301574c |           | 965dbeea-a6d5-467d-9683-914b744ad1ef | 2021-02-10 07:25:48 | 243.8      | 8.55          | 252.35      |             |                  |                       |              | preparing | 5ea3780600e4eb306c086141d0303bca | 2022-10-09 20:19:59 | 2022-10-09 20:19:59 | 2022-10-17 23:28:41 |



