/* Question

How many men and women bought Food & Beverage aand did not
pay with cash?

*/

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

/* OR */ 

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