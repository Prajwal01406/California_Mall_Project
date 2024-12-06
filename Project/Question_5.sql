/* Question 

Rank the malls based on their percentage share of customers.

*/


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


