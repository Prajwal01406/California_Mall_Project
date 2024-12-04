/* Question 

Top 3 Shopping malls based on the number of customers and sales 

*/

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
    
