use yt_pro

SELECT * FROM pizza_sales

-----------------------------------------------------KPI's-----------------------------------------------------------------------------------

--1. TOTAL REVENUE

SELECT 
	SUM(total_price) TOTAL_REV
	
FROM
	pizza_sales

--2. AVERAGE ORDER VALUE

SELECT 
	SUM(total_price) / count(distinct order_id) AVG_ORDER
FROM
	pizza_sales

--3. TOTAL PIZZA SOLD 

SELECT
	SUM(quantity) TOTAL_SOLD
FROM
	pizza_sales


--4. TOTAL ORDERS

SELECT 
	COUNT(distinct order_id)
FROM 
	pizza_sales
	

--5. AVERAGE PIZZA'S PER ORDER

select * from pizza_sales

select cast(cast(sum(quantity) as decimal (10,2)) / 
cast(count(distinct order_id)as  decimal (10,2))  as decimal (10,2)) avg_pizza from pizza_sales


---------------------------------------------------- PROBLEM STATEMENT ----------------------------------------------------------------------------

--1. Daily Trend for TOTAL ORDERS

SELECT * FROM pizza_sales

SELECT  DATENAME(DW,order_date) DAY, COUNT(DISTINCT order_id) TOTAL_ORDER
FROM pizza_sales GROUP BY DATENAME(DW,order_date) 

--2. MONTHLY TREND FOR TOTAL ORDERS

SELECT DATENAME(MONTH, order_date) as MONTH ,
COUNT(DISTINCT order_id) TOTAL_ORDER FROM pizza_sales 
GROUP BY DATENAME(MONTH, order_date)
ORDER BY TOTAL_ORDER DESC


--3. PERCENTAGE OF SALES BY PIZZA CATEGORY

SELECT pizza_category,
SUM(total_price) Total_Sale,
SUM(total_price)*100 /
(SELECT SUM(total_price) from pizza_sales WHERE MONTH(order_date) = 1 ) Percentage_of_Total_Sale
FROM pizza_sales
WHERE MONTH(order_date) = 1  
GROUP BY pizza_category

--4. PERCENTAGE OF SALES BY PIZZA SIZE

SELECT 
	pizza_size,
	CAST(SUM(total_price)AS decimal (10,2)) Total_Sale,
	CAST(SUM(total_price)*100 /
	(
	SELECT 
		SUM(total_price) 
	FROM 
		pizza_sales
	WHERE
	DATEPART(QUARTER,order_date) = 1)AS DECIMAL (10,2)) Percentage_of_Total_Sale
FROM 
	pizza_sales
WHERE
	DATEPART(QUARTER,order_date) = 1
GROUP BY 
	pizza_size
ORDER BY
	Percentage_of_Total_Sale


--6. TOP 5 BEST SELLER BY REVENUE, TOTAL QUANTITY AND TOTAL ORDERS

--TOP 5 BY REVENUE
SELECT 
	TOP 5 pizza_name,
	SUM(total_price) TOTAL_REV
FROM
	pizza_sales
GROUP BY 
	pizza_name
ORDER BY
	TOTAL_REV DESC

--TOP 5 BY QUANTITY

SELECT 
	TOP 5 pizza_name,
	SUM(quantity) TOTAL_QUAN
FROM
	pizza_sales
GROUP BY 
	pizza_name
ORDER BY
	TOTAL_QUAN DESC

-- TOP 5 BY ORDER

SELECT 
	TOP 5 pizza_name,
	COUNT(DISTINCT order_id) TOTAL_ORDER
FROM
	pizza_sales
GROUP BY 
	pizza_name
ORDER BY
	TOTAL_ORDER DESC

--7. BOTTOM 5 BEST SELLER BY REVENUE, TOTAL QUANTITY AND TOTAL ORDERS

-- BOTTOM 5 BY REVENUE
SELECT 
	TOP 5 pizza_name,
	SUM(total_price) TOTAL_REV
FROM
	pizza_sales
GROUP BY 
	pizza_name
ORDER BY
	TOTAL_REV ASC

-- BOTTOM 5 BY QUANTITY

SELECT 
	TOP 5 pizza_name,
	SUM(quantity) TOTAL_QUAN
FROM
	pizza_sales
GROUP BY 
	pizza_name
ORDER BY
	TOTAL_QUAN ASC

-- BOTTOM 5 BY ORDER

SELECT 
	TOP 5 pizza_name,
	COUNT(DISTINCT order_id) TOTAL_ORDER
FROM
	pizza_sales
GROUP BY 
	pizza_name
ORDER BY
	TOTAL_ORDER ASC