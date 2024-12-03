CREATE TABLE customer_data 
(customer_id TEXT PRIMARY KEY,
gender TEXT,
age INT,
payment_mode TEXT);

CREATE TABLE sales_data 
(invoice_no TEXT,
customer_id TEXT,
category TEXT,
quantity INT,
invoice_date TIMESTAMP,
price NUMERIC,
shopping_mall TEXT,
FOREIGN KEY(customer_id) REFERENCES customer_data(customer_id),
FOREIGN KEY(shopping_mall) REFERENCES shopping_mall_data(shopping_mall)
 );

CREATE TABLE shopping_mall_data
(shopping_mall TEXT PRIMARY KEY,
construction_year INT,
area INT,
location TEXT,
store_count INT
);


ALTER TABLE sales_data
ALTER COLUMN invoice_date TYPE TEXT;

ALTER TABLE shopping_mall_data 
ALTER COLUMN area TYPE NUMERIC;

UPDATE shopping_mall_data
SET shopping_mall = 'Irvine Spectrum' where store_count = 130;

SELECT *
FROM customer_data;

SELECT *
FROM sales_data;

SELECT *
FROM shopping_mall_data;