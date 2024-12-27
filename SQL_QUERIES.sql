1. **Write a query to calculate the total revenue generated from pizza sales?**:

SELECT SUM(total_price) AS total_revenue 
FROM pizza_sales;;


2. **Write a SQL query to calculate the average order value (AOV) by dividing the total revenue by the number of unique orders. Format the result as a decimal with two places?**:

SELECT 
       CAST(SUM(total_price) / COUNT(DISTINCT order_id) AS DECIMAL(10, 2)) AS avg_order_value 
FROM pizza_sales;


3. **Write a SQL query to calculate the total number of pizzas sold?**:

SELECT 
       SUM(quantity) AS total_pizzas_sold 
FROM pizza_sales;


4. **Write a SQL query to calculate the total number of orders?**:

SELECT 
       COUNT(DISTINCT order_id) AS total_orders 
FROM dbo.pizza_sales;


5. **Write a SQL query to calculate the average number of pizzas sold per order?**:

SELECT 
            CAST(CAST(SUM(quantity) AS DECIMAL(10, 2)) / 
            CAST(COUNT(DISTINCT order_id) AS DECIMAL(10, 2)) AS DECIMAL(10, 2)) AS avg_pizza_per_order 
FROM pizza_sales;


6. **Write a SQL query to find the top 5 selling pizzas?**:

SELECT  
       pizza_name, SUM(total_price) AS total_sales 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY total_sales DESC
LIMIT 5;



7. **Write a SQL query to find the top 5 Worst selling pizzas?**:

SELECT 
        pizza_name, SUM(total_price) AS total_sales 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY total_sales
LIMIT 5;


8. **Write a SQL query to find the total number of orders for each day of the week, sorted by the total orders in descending order? **:

SELECT 
       DAYNAME(order_date) AS order_day, 
	   COUNT(DISTINCT order_id) AS total_orders  
FROM pizza_sales  
GROUP BY DAYNAME(order_date)  
ORDER BY total_orders DESC;  



9. **Write an SQL query to retrieve the total number of orders placed for each hour of the day?**:

SELECT 
       HOUR(order_time) AS order_hour, 
	   COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales 
GROUP BY HOUR(order_time) 
ORDER BY order_hour;


10. **Write a query to identify the best-selling pizza by total quantity?**:

SELECT 
       pizza_name, 
	   SUM(quantity) AS total_sold 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_sold DESC;


11. **Write a query to find the total number of pizzas sold for each pizza category?**:

SELECT 
      pizza_category, 
	  SUM(quantity) AS total_pizzas_sold 
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_pizzas_sold DESC;


12. **Write a query to manipulation of pizza size?**:

SELECT 
      CASE 
           WHEN pizza_size = 'M' THEN 'Medium'
           WHEN pizza_size = 'S' THEN 'Regular'
           WHEN pizza_size = 'L' THEN 'Large'
           WHEN pizza_size = 'XL' THEN 'X-Large'
           WHEN pizza_size = 'XXL' THEN 'XX-Large'
       END AS pizza_size, SUM(total_price) AS total_quantity 
FROM pizza_sales 
GROUP BY pizza_size;


13. **Write an SQL query to find the number of returning customers by counting distinct order_id values for customers who have placed more than one order?**:

SELECT 
       COUNT(DISTINCT order_id) AS returning_customer 
FROM pizza_sales 
GROUP BY order_id 
HAVING COUNT(1) > 1;



14. **Write an SQL query to find the daily sale trends?**:

SELECT 
       order_date, 
	   SUM(total_price) AS total_sales 
FROM dbo.pizza_sales 
GROUP BY order_date;



15. **Write an SQL query to calculate the total sales for each month?**:

SELECT 
       MONTH(order_date) AS sales_month, 
	   SUM(total_price) AS total_sales 
FROM pizza_sales 
GROUP BY MONTH(order_date) 
ORDER BY sales_month;



16. **Write an SQL query to calculate the total sales for each year?**:

SELECT 
       YEAR(order_date) AS sales_year, 
	   SUM(total_price) AS total_sales 
FROM pizza_sales 
GROUP BY YEAR(order_date) AS sales_year
ORDER BY sales_year;



17. **Write an SQL query to calculate the total sales month over month?**:

WITH monthly_sales AS (
    SELECT 
	       YEAR(order_date) AS sales_year,
           MONTH(order_date) AS sales_month,
           SUM(total_price) AS total_sales
    FROM pizza_sales
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT sales_year,
       sales_month,
       total_sales,
       LAG(total_sales, 1) OVER (ORDER BY sales_year, sales_month) AS previous_months_sales,
       (total_sales - LAG(total_sales, 1) OVER (ORDER BY sales_year, sales_month)) / 
       LAG(total_sales, 1) OVER (ORDER BY sales_year, sales_month) * 100 AS MoM_growth
FROM monthly_sales;



18. **Write an SQL query to calculate the total sales year over year?**:

WITH yearly_sales AS (
    SELECT 
	       YEAR(order_date) AS sales_year,
           SUM(total_price) AS total_sales
    FROM pizza_sales
    GROUP BY YEAR(order_date)
)
SELECT sales_year,
       total_sales,
       LAG(total_sales, 1) OVER (ORDER BY sales_year) AS previous_year_sales,
       (total_sales - LAG(total_sales, 1) OVER (ORDER BY sales_year)) / 
       LAG(total_sales, 1) OVER (ORDER BY sales_year) * 100 AS YoY_growth
FROM yearly_sales;



19. **Write an SQL query to calculate the total sales for the current year up to the present date?**:

SELECT 
       YEAR(order_date) AS sales_year, 
	   SUM(total_price) AS total_sales
FROM pizza_sales
WHERE order_date BETWEEN '2024-01-01' AND CURDATE()
GROUP BY YEAR(order_date)
ORDER BY sales_year;



20. **Write an SQL query to calculate the total sales for each quarter of each year?**:

SELECT 
       YEAR(order_date) AS sales_year,
       QUARTER(order_date) AS quarter_sales,
       SUM(total_price) AS total_sales
FROM pizza_sales
GROUP BY YEAR(order_date), QUARTER(order_date)
ORDER BY sales_year, quarter_sales;


21. **Write an SQL query to calculate the average sales for each month of each year?**:

SELECT 
       YEAR(order_date) AS sales_year,
       MONTH(order_date) AS sales_month,
       AVG(total_price) AS total_sales
FROM pizza_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY sales_year, sales_month;


22. **Write an SQL query to calculate the total sales for each day of the week?**:

SELECT 
       DAYNAME(order_date) AS Day_of_Week,
       SUM(total_price) AS Sales
FROM pizza_sales
GROUP BY DAYNAME(order_date)
ORDER BY CASE DAYNAME(order_date)
             WHEN 'Sunday' THEN 1
             WHEN 'Monday' THEN 2
             WHEN 'Tuesday' THEN 3
             WHEN 'Wednesday' THEN 4
             WHEN 'Thursday' THEN 5
             WHEN 'Friday' THEN 6
             WHEN 'Saturday' THEN 7
         END;



23. **Write an SQL query to find the peak order hours by counting the number of orders placed for each hour of the day?**:

SELECT 
       HOUR(order_time) AS Order_Hour,
       COUNT(order_id) AS Order_Count
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY Order_Count DESC;


24. **Write an SQL query to find the order acquistion rate?**:

SELECT 
       YEAR(order_date) AS Order_year,
       COUNT(DISTINCT order_id) AS new_order
FROM pizza_sales
WHERE order_date BETWEEN '2015-01-01' AND CURDATE()
GROUP BY YEAR(order_date);



25. **Write an SQL query to calculate the sales for each day, the sales from the previous day, and the day-over-day changes in sales?**:

SELECT 
      order_date,
      total_price,
      LAG(total_price, 1) OVER (ORDER BY order_date) AS previous_day_sales,
      total_price - COALESCE(LAG(total_price, 1) OVER (ORDER BY order_date), 0) AS daily_changes
FROM pizza_sales
ORDER BY order_date;
