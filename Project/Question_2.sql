/* Question 

How many men aged below 30 spent 2k or above
on shoes in malls which were constructed before 1970?

*/

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


