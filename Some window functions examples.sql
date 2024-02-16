IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Orders')
BEGIN
	CREATE TABLE [dbo].[Orders]
	(
		order_id INT,
		order_date DATE,
		customer_name VARCHAR(250),
		city VARCHAR(100),	
		order_amount MONEY
	)
 
	INSERT INTO [dbo].[Orders]
	SELECT '1001','04/01/2017','David Smith','GuildFord',10000
	UNION ALL	  
	SELECT '1002','04/02/2017','David Jones','Arlington',20000
	UNION ALL	  
	SELECT '1003','04/03/2017','John Smith','Shalford',5000
	UNION ALL	  
	SELECT '1004','04/04/2017','Michael Smith','GuildFord',15000
	UNION ALL	  
	SELECT '1005','04/05/2017','David Williams','Shalford',7000
	UNION ALL	  
	SELECT '1006','04/06/2017','Paum Smith','GuildFord',25000
	UNION ALL	 
	SELECT '1007','04/10/2017','Andrew Smith','Arlington',15000
	UNION ALL	  
	SELECT '1008','04/11/2017','David Brown','Arlington',2000
	UNION ALL	  
	SELECT '1009','04/20/2017','Robert Smith','Shalford',1000
	UNION ALL	  
	SELECT '1010','04/25/2017','Peter Smith','GuildFord',500
 END


SELECT city, SUM(order_amount) total_order_amount
FROM [dbo].[Orders] GROUP BY city

SELECT order_id, order_date, customer_name, city, order_amount
 ,SUM(order_amount) OVER(PARTITION BY city) as grand_total 
FROM [dbo].[Orders]

SELECT order_id, order_date, customer_name, city, order_amount
 ,AVG(order_amount) OVER(PARTITION BY city, MONTH(order_date)) as   average_order_amount 
FROM [dbo].[Orders]

SELECT order_id, order_date, customer_name, city, order_amount
 ,MIN(order_amount) OVER(PARTITION BY city) as minimum_order_amount 
FROM [dbo].[Orders]

SELECT order_id, order_date, customer_name, city, order_amount
 ,MAX(order_amount) OVER(PARTITION BY city) as maximum_order_amount 
FROM [dbo].[Orders] 
 
 SELECT order_id, order_date, customer_name, city, order_amount
 ,COUNT(order_id) OVER(PARTITION BY city) as total_orders
FROM [dbo].[Orders]

SELECT order_id,order_date,customer_name,city, 
RANK() OVER(ORDER BY order_amount DESC) [rank]
FROM [dbo].[Orders]

 
SELECT order_id,order_date,customer_name,city, order_amount,
DENSE_RANK() OVER(ORDER BY order_amount DESC) [dense_rank]
FROM [dbo].[Orders]



SELECT order_id,order_date,customer_name,city, order_amount,
ROW_NUMBER() OVER(PARTITION BY city ORDER BY order_amount DESC) [row_number]
FROM [dbo].[Orders]


-- Percentile
SELECT order_id,order_date,customer_name,city, order_amount,
NTILE(4) OVER(ORDER BY order_amount) [ntile]
FROM [dbo].[Orders]


SELECT order_id,order_date,customer_name,city, order_amount,
FIRST_VALUE(order_date) OVER(PARTITION BY city ORDER BY city) first_order_date,
LAST_VALUE(order_date) OVER(PARTITION BY city ORDER BY city) last_order_date
FROM [dbo].[Orders]
