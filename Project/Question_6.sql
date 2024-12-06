/* Question

Numer of males and females below the average age who purchased goods worth more than 
1200 with cash.

Conditiions - 
1. mall should not be located in Los Angles.
2. constructed after the year 1980.
3.area is more than 100,000 sqm.

*/

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