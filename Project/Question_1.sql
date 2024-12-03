/*Question -

 What are the Shopping Malls that have atleast 150000sqm of area and sell clothings priced under 500?

*/

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

