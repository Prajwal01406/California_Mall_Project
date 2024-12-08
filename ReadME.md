
# Introduction #
Let's dive into the sales data of all the **shopping malls** located in **State of California**. This project focuses on analysing the sales, according to the porduct, price, quantity etc, made by all the shopping malls.You can check out the **SQL** queries of the project [here](Project). 

# Background #
This project was made with a curiosity to understand the **tastes** and **preferences** of the customers in the state of California according the age group, gender etc. This project will help analyse which **shopping mall** is prefered by the **customers**.

### Questions I wanted to answer ###

1.  What are the Shopping Malls that have atleast 150000sqm of area and sell clothings priced under 500?

2. How many men aged below 30 spent 2k or above
on shoes in malls which were constructed before 1970?

3. Top 3 Shopping malls based on the number of customers and sales.

4. How many men and women bought Food & Beverage and did not
pay with cash?

5. Rank the malls based on their percentage share of customers.

6. Numer of males and females below the average age who purchased goods worth more than 
1200 with cash. 


7. Number of individuals exceeding the average age that purchased
a)Toys.
b)Clothing.
c)Technology.
With mode of payment as 
a)Cash.
B)Credit Card.

Conditiions for question 6 & 7 - 
1.mall should not be located in Los Angles.
2.constructed after the year 1980.
3.area is more than 100,000 sqm.


**These questions were developed by myself, [Tavishi Mahajan](https://www.linkedin.com/in/tavishi-mahajan-055763319/) and [Kabeer Kulkarni](https://www.linkedin.com/in/kabeer-kulkarni-aa0b76331/).**

## Source ##
The source for the data used in this project is **Kaggle** and you can download all the excel files from [here](https://www.kaggle.com/datasets/captaindatasets/istanbul-mall).

## Tools that I used ##
For this project, I utilized a range of essential tools for data analysis. The specific tools used and the tasks they facilitated are detailed below.

- **MS Excel** - used MS Excel to assign correct data types to all the columns and then convert the Excel file(.xls) to CSV files for further analysis.

- **SQL** - The backbone of my project, allowing me to query out all the specific answers that I was looking for. 

- **Postgre SQL** - This database management system was utilized to load all the CSV files into a dedicated database created specifically for the project, stored locally on my device.

- **Visual Studio Code** -  My go-to for database management and executing SQL querries.

- **Power BI** - This software was employed to visually present all the results derived from the queries for better understanding.

- **Git and Github** - For sharing the analysis with all the curious data nerd on the internet.


# The Analysis 

### 1. What are the Shopping Malls that have atleast 150000sqm of area and sell clothings priced under 500?

To following query was used to find the answer for this question.

```sql
SELECT 
    COUNT(SD.shopping_mall) AS Clothing_count,
    SD.shopping_mall,
    area

FROM 
    sales_data SD JOIN shopping_mall_data SM 
    ON SD.shopping_mall = SM.shopping_mall

WHERE 
    area >= 150000 
    AND category = 'Clothing'
    AND price < 500

GROUP BY 
   SD.shopping_mall,area

ORDER BY area DESC;
```

The following table is the result obtained from the querry.

| Clothing Count | Shopping Mall            | Area (sq ft) |
|----------------|--------------------------|--------------|
| 1400           | South Coast Plaza        | 250,000.00   |
| 1359           | Del Amo Fashion Center   | 232,000.00   |
| 644            | Westfield Valley Fair    | 220,000.00   |
| 360            | Fashion Valley           | 161,000.00   |

We can see that **South Coast Plaza** has the heighest sales for clothings priced under $500 with a dashing 1400 sales followed by **Del Amo Fashion Centre** and **Westfield Valley Fair**.

### 2. How many men aged below 30 spent 2k or above on shoes in malls which were constructed before 1970?

To find the answer we I wrote the following Query.

```sql
SELECT
    COUNT(SD.customer_id) AS Sale_count,
    SD.shopping_mall,
    construction_year

FROM 
    customer_data CD JOIN sales_data SD 
    ON CD.customer_id = SD.customer_id JOIN 
    shopping_mall_data SM ON 
    SD.shopping_mall = SM.shopping_mall

WHERE 
    age < 30
    AND price > 2000
    AND gender = 'Male'
    AND construction_year < 1970

GROUP BY SD.shopping_mall,construction_year

ORDER BY Sale_count DESC;
```
This query provided me with a detailed table as the answer for my curiosity.

| Sale Count | Shopping Mall             | Construction Year |
|------------|---------------------------|-------------------|
| 174        | Del Amo Fashion Center    | 1961              |
| 145        | South Coast Plaza         | 1967              |
| 109        | Westfield Century City    | 1964              |
| 77         | Stanford Shopping Center  | 1956              |


We can see that **Del Amo Fashion Centre** ranks the heighest with a bold count of *174* shoe sales followed by **South Coast Plaza** and **Westfield Century City**.

### 3.Top 3 Shopping malls based on the number of customers and sales.

For finding the top 3 best malls in the state of California I wrote the following query which provided me the answer within seconds.

```sql
SELECT 
    shopping_mall,
    COUNT(customer_id) AS customers,
    SUM(quantity) AS sales 

FROM 
    sales_data

GROUP BY
    shopping_mall

ORDER BY 
    customers DESC, sales DESC

LIMIT 3;
```
The solution or results are as follows.

| Shopping Mall             | Customers | Sales  |
|---------------------------|-----------|--------|
| Del Amo Fashion Center    | 19,943    | 60,114 |
| South Coast Plaza         | 19,823    | 59,457 |
| Westfield Century City    | 15,011    | 44,894 |

Again **Del Amo Fashion Centre** tops the list with a massive customer base of 19,943 and overall sales of 60,114 goods.
second on the list is **South Coast Plaza** followed by **Westfield Century City**.

### 4. How many men and women bought Food & Beverage aand did not pay with cash? 

I found two ways to fnd the solution for this question, both of them are listed below.

```sql
SELECT
    SUM( CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) AS Male,
    SUM( CASE WHEN gender = 'Female' THEN 1 Else 0 END) AS Female,
    payment_mode,
    SUM(price) AS Amt_spent

FROM
    customer_data CD JOIN sales_data SD
    ON CD.customer_id = SD.customer_id

WHERE 
    category = 'Food & Beverage'
    AND payment_mode != 'Cash'

GROUP BY payment_mode;
``` 
### OR

```sql
SELECT
    COUNT( CASE WHEN gender = 'Male' THEN 1  END) AS Male,
    COUNT( CASE WHEN gender = 'Female' THEN 1  END) AS Female,
    payment_mode,
    SUM(price) AS Amt_spent

FROM
    customer_data CD JOIN sales_data SD
    ON CD.customer_id = SD.customer_id

WHERE 
    category = 'Food & Beverage'
    AND payment_mode != 'Cash'

GROUP BY payment_mode;
```

Both queries will lead us to the following answer.

| Male | Female | Payment Mode | Amount Spent |
|------|--------|--------------|--------------|
| 2120 | 3130   | Credit Card  | 82,592.16    |
| 1180 | 1759   | Debit Card   | 46,348.26    |

We can see that 2,120 Men and 3,130 Women spent a total of $82,592.16 on Food and beverage using Credit card.Whereas only 1,180 Men and 1,759 Women used Debit card and spent nearly half the amount spent by credit card holder ie. $46.348,

### 5.Rank the malls based on their percentage share of customers.

This was the trickiest question that I came across in this entire project the solution for this question is a small query but covers various concepts of SQL very well.The query is

```sql
SELECT
    shopping_mall,
    COUNT(customer_id) AS total_cust,
    ROUND((COUNT(customer_id) * 100.0) / total.total_cust, 2) AS percentage
FROM 
    sales_data
JOIN 
    (SELECT COUNT(customer_id) AS total_cust FROM sales_data) AS total
ON 
    TRUE
GROUP BY 
    shopping_mall, total.total_cust
ORDER BY percentage DESC;
```
The following table ranks all the shopping malls according to the share of customers.
| Shopping Mall             | Total Customers | Percentage |
|---------------------------|-----------------|------------|
| Del Amo Fashion Center    | 19,943          | 20.05%     |
| South Coast Plaza         | 19,823          | 19.93%     |
| Westfield Century City    | 15,011          | 15.09%     |
| Stanford Shopping Center  | 10,161          | 10.22%     |
| Westfield Valley Fair     | 9,781           | 9.83%      |
| Fashion Valley            | 5,075           | 5.10%      |
| Irvine Spectrum           | 4,991           | 5.02%      |
| Beverly Center            | 4,947           | 4.97%      |
| Glendale Galleria         | 4,914           | 4.94%      |
| The Grove                 | 4,811           | 4.84%      |

Del Amo Fashion Centre tops the list again! by bagging 20% of customers.

### 6.Numer of males and females below the average age who purchased goods worth more than 1200 with cash.

### Conditiions - 
### 1. mall should not be located in Los Angles.
### 2. constructed after the year 1980.
### 3.area is more than 100,000 sqm.

This question covers almost all the important concepts of a SQL Query from CASES to CTE's. This detailed question was developed by Kabeer Kulkarni. 
below is the query that I wrote to find the answer.


```sql
WITH Avg_age AS 
(
SELECT AVG(age) AS avg_age
FROM customer_data
)

SELECT 
    payment_mode,
    SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) AS Male,
    SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) AS Female

FROM 
    sales_data SD JOIN customer_data CD 
    ON SD.customer_id = CD.customer_id JOIN
    shopping_mall_data SMD 
    ON SD.shopping_mall = SMD.shopping_mall JOIN 
    Avg_age AG ON AG.avg_age > age 

WHERE
     SMD.location != 'Los Angeles' 
    AND construction_year > 1980
    AND area > 100000
    AND price > 1200
    AND payment_mode = 'Cash'

GROUP BY payment_mode;
```
The results of this query are.

| Payment Mode | Male | Female |
|--------------|------|--------|
| Cash         | 368  | 523    |

There are only 523 Women and 368 Men who fall under the conditions and have paid cash to purchase goods worth > $1200.

### 7.Number of individuals exceeding the average age that purchased a)Toys.b)Clothing.c)Technology.With mode of payment as a)Cash.B)Credit Card.
### Conditiions - 
### 1. mall should not be located in Los Angles.
### 2. constructed after the year 1980.
### 3.area is more than 100,000 sqm.

This question is similar to the previous one but has various sub questions that needs to be accurately answered.The query used to perform the task is as follows.

```sql
WITH Avg_age AS 
(
SELECT AVG(age) AS avg_age
FROM customer_data
)

SELECT 
    Payment_mode,
    SUM(CASE WHEN category = 'Toys' THEN 1 ELSE 0 END) AS Toys,
    SUM(CASE WHEN category = 'Clothing' THEN 1 ELSE 0 END) AS Clothing,
    SUM(CASE WHEN category = 'Technology' THEN 1 ELSE 0 END) AS Technology
FROM  
    sales_data SD JOIN customer_data CD
    ON SD.customer_id = CD.customer_id JOIN shopping_mall_data SMD
    ON SD.shopping_mall = SMD.shopping_mall JOIN Avg_age AG 
    ON CD.age > AG.avg_age

WHERE
    SMD.location != 'Los Angeles' 
    AND construction_year > 1980
    AND area > 100000
    AND payment_mode != 'Debit Card'

GROUP BY payment_mode;
```
Solution Table

| Payment Mode | Toys | Clothing | Technology |
|--------------|------|----------|------------|
| Credit Card  | 236  | 908      | 119        |
| Cash         | 376  | 1125     | 163        |

This detailed table accurately shows the answers for all the things that the above question asked for.

# Visualization 

As I was solving all the questions I found out that the resulted tables and answers were very boring to analyse and understand. It looked so shabby and boring and I was not able to concentrate on the results.
So in order to fix this issue I first **downloaded** all the results in **CSV** format and uploaded them to **Power Bi** a software used to visualize tabular data.
Then I went ahead an created varous graphs and visuals to present this datain a more systematic and easily understandable form, which is also very attractive.

You can download the solution file from [here](Visualization/)

The following images show the graphs.

 ![Visuals1](Visualization/Screenshot%202024-12-08%20154200.png)

![Visuals2](Visualization/Screenshot%202024-12-08%20154135.png)

# What I learned


I had some basic knowledge of SQL and databases, which I gained from watching videos and the free course made by [Luke Barousse](https://www.linkedin.com/in/luke-b/).

However, this entire project helped me gain experience in mastering the practical skills of SQL and databases.

I was able to create my own database and load the CSV files all by myself, which was very exciting work.

I faced a lot of problems during this project, but I was able to solve every error and tackle every obstacle.

I learned how to **visualize** the data using **Power BI**.

In short I was able to learn practical skills of **SQL, Database and Power Bi** is a very dynamic way.

# Conclusion

### I was able to bring out several insights into the world of Shopping malls in the state of California.

1. **Total Sales** made by all the shopping malls in California summed upto a whopping **$68.55 Million**.

2. **Total Quantity** of goods sold by these malls summed up to **299,000 goods**.

3. **Del Amo Fashion Centre** ranks as the best shopping mall in the state as it have the heighest share of customers and sales.

4. **Credit Card** was the most prefered cashless mode of payment by both men and Women residing in California.

5. **Top 3 best shopping malls** are 
- Del Amo Fashion Centre.
- South Coast Plaza. 
- West Field Century City.

This project helped me enchance various data analystical skills such as SQL, EXCEL, POSTGRE, VISUAL STUDIO CODE, POWER BI, GIT and GIT HUB.
I believe that these insights will be helpful for people searching for best malls in the state of California.