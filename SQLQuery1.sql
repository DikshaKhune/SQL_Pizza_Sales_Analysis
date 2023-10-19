
--KPI'S REQUIREMENTS ( Key Performance Indicator)

SELECT * FROM pizza_sales

--total revenue

SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales

--average order value

SELECT SUM(total_price) / COUNT (DISTINCT order_id) AS Avg_Order_Value FROM pizza_sales

--total pizza sold

SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales

--total orders

SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales

--avg pizzas per order

SELECT SUM(quantity) / COUNT(DISTINCT order_id) AS Avg_Pizzas_Per_Order FROM pizza_sales

--avg pizzas per order ( in Decimal form) 

SELECT CAST(SUM(quantity) AS DECIMAL(10, 2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10, 2)) AS Avg_Pizzas_Per_Order FROM pizza_sales;


--CHARTS REQUIREMENTS

--daily trend for total orders 

SELECT DATENAME(DW, order_date) AS Order_day, COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales
GROUP BY DATENAME(DW, order_date);

--Hourly trend for total orders

SELECT DATEPART(HOUR, order_time) AS Order_hour, COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time);

--Percentage of sales by pizza category

SELECT pizza_category, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS PCT FROM pizza_sales
GROUP BY pizza_category

--percentage of sales by pizza category (applying filters)

SELECT pizza_category, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 3) AS PCT FROM pizza_sales
WHERE MONTH(order_date) = 3
GROUP BY pizza_category

--percentage by sales by pizza size

SELECT pizza_size, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT ASC

--Total pizzas sold by pizza category

SELECT pizza_category, SUM(quantity) AS pizza_sold FROM pizza_sales
GROUP BY pizza_category

--Top 5 best sellers by total pizzas sold

SELECT TOP 5 pizza_name, SUM(quantity) AS total_pizza_sold FROM pizza_sales 
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC

--Top 5 worst sellers by total pizzas sold

SELECT TOP 5 pizza_name, SUM(quantity) AS total_pizza_sold FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC
