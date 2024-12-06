/* Question

Number of individuals exceeding the average age that purchased
a)Toys
b)Clothing
c)Technology

with mode of payment as 
a)Cash
B)Credit Card.

*/

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