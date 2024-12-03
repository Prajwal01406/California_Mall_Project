COPY customer_data
FROM 'D:\programme\California_Mall_Project\Sale data of a California Mall/customer_data.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY sales_data
FROM 'D:\programme\California_Mall_Project\Sale data of a California Mall/sales_data.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY shopping_mall_data
FROM 'D:\programme\California_Mall_Project\Sale data of a California Mall/shopping_mall_data.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

