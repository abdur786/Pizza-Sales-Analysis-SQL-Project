# Pizza Sales Analysis SQL Project

## Project Overview

**Project Title**: Pizza Sales Analysis
**Level**: Beginner  
**Database**: `pizza_sales_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze pizza sales data. The project involves setting up a pizza sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a pizza sales database**: Create and populate a pizza sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `pizza_sales_db`.
- **Table Creation**: A table named `pizza_sales` is created to store the sales data. The table structure includes columns for pizza_id,order_id,total_orders,pizza_name_id,quantity,order_date,order_time,unit_price,total_price,pizza_size,pizza_category,pizza_ingredients,and pizza_name.

```sql
CREATE DATABASE pizza_sales_db;

CREATE TABLE pizza_sales_db.pizza_sales (
    pizza_id INT,
    order_id INT,
    pizza_name_id varchar(200),
    quantity INT,
    order_date DATE,
    order_time TIME ,
    unit_price DECIMAL(10, 2),
    total_price DECIMAL(10, 2) ,
    pizza_size VARCHAR(50),
    pizza_category VARCHAR(50),
    pizza_ingredients TEXT,
    pizza_name VARCHAR(100)
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Order Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM pizza_sales;
SELECT COUNT(DISTINCT order_id) FROM pizza_sales;
SELECT DISTINCT pizza_category FROM pizza_sales;

SELECT * FROM pizza_sales
WHERE 
    (pizza_id IS NULL OR order_id IS NULL OR order_date IS NULL) 
    ;

DELETE FROM pizza_sales
WHERE 
    (pizza_id IS NULL OR order_id IS NULL OR order_date IS NULL);
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a query to calculate the total revenue generated from pizza sales?**:
```sql
SELECT SUM(total_price) AS total_revenue 
FROM pizza_sales;;
```

2. **Write a SQL query to calculate the average order value (AOV) by dividing the total revenue by the number of unique orders. Format the result as a decimal with two places?**:
```sql
SELECT 
       CAST(SUM(total_price) / COUNT(DISTINCT order_id) AS DECIMAL(10, 2)) AS avg_order_value 
FROM pizza_sales;
```

3. **Write a SQL query to calculate the total number of pizzas sold?**:
```sql
SELECT 
       SUM(quantity) AS total_pizzas_sold 
FROM pizza_sales;
```

4. **Write a SQL query to calculate the total number of orders?**:
```sql
SELECT 
       COUNT(DISTINCT order_id) AS total_orders 
FROM dbo.pizza_sales;
```

5. **Write a SQL query to calculate the average number of pizzas sold per order?**:
```sql
SELECT 
            CAST(CAST(SUM(quantity) AS DECIMAL(10, 2)) / 
            CAST(COUNT(DISTINCT order_id) AS DECIMAL(10, 2)) AS DECIMAL(10, 2)) AS avg_pizza_per_order 
FROM pizza_sales;
```

6. **Write a SQL query to find the top 5 selling pizzas?**:
```sql
SELECT  
       pizza_name, SUM(total_price) AS total_sales 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY total_sales DESC
LIMIT 5;

```

7. **Write a SQL query to find the top 5 Worst selling pizzas?**:
```sql
SELECT 
        pizza_name, SUM(total_price) AS total_sales 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY total_sales
LIMIT 5;
```

8. **Write a SQL query to find the total number of orders for each day of the week, sorted by the total orders in descending order? **:
```sql
SELECT 
       DAYNAME(order_date) AS order_day, 
	   COUNT(DISTINCT order_id) AS total_orders  
FROM pizza_sales  
GROUP BY DAYNAME(order_date)  
ORDER BY total_orders DESC;  

```

9. **Write an SQL query to retrieve the total number of orders placed for each hour of the day?**:
```sql
SELECT 
       HOUR(order_time) AS order_hour, 
	   COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales 
GROUP BY HOUR(order_time) 
ORDER BY order_hour;
```

10. **Write a query to identify the best-selling pizza by total quantity?**:
```sql
SELECT 
       pizza_name, 
	   SUM(quantity) AS total_sold 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_sold DESC;
```

11. **Write a query to find the total number of pizzas sold for each pizza category?**:
```sql
SELECT 
      pizza_category, 
	  SUM(quantity) AS total_pizzas_sold 
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_pizzas_sold DESC;
```

12. **Write a query to manipulation of pizza size?**:
```sql
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
```

13. **Write an SQL query to find the number of returning customers by counting distinct order_id values for customers who have placed more than one order?**:
```sql
SELECT 
       COUNT(DISTINCT order_id) AS returning_customer 
FROM pizza_sales 
GROUP BY order_id 
HAVING COUNT(1) > 1;

```

14. **Write an SQL query to find the daily sale trends?**:
```sql
SELECT 
       order_date, 
	   SUM(total_price) AS total_sales 
FROM dbo.pizza_sales 
GROUP BY order_date;

```

15. **Write an SQL query to calculate the total sales for each month?**:
```sql
SELECT 
       MONTH(order_date) AS sales_month, 
	   SUM(total_price) AS total_sales 
FROM pizza_sales 
GROUP BY MONTH(order_date) 
ORDER BY sales_month;

```

16. **Write an SQL query to calculate the total sales for each year?**:
```sql
SELECT 
       YEAR(order_date) AS sales_year, 
	   SUM(total_price) AS total_sales 
FROM pizza_sales 
GROUP BY YEAR(order_date) AS sales_year
ORDER BY sales_year;

```

17. **Write an SQL query to calculate the total sales month over month?**:
```sql
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

```

18. **Write an SQL query to calculate the total sales year over year?**:
```sql
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

```

19. **Write an SQL query to calculate the total sales for the current year up to the present date?**:
```sql
SELECT 
       YEAR(order_date) AS sales_year, 
	   SUM(total_price) AS total_sales
FROM pizza_sales
WHERE order_date BETWEEN '2024-01-01' AND CURDATE()
GROUP BY YEAR(order_date)
ORDER BY sales_year;

```

20. **Write an SQL query to calculate the total sales for each quarter of each year?**:
```sql
SELECT 
       YEAR(order_date) AS sales_year,
       QUARTER(order_date) AS quarter_sales,
       SUM(total_price) AS total_sales
FROM pizza_sales
GROUP BY YEAR(order_date), QUARTER(order_date)
ORDER BY sales_year, quarter_sales;
```

21. **Write an SQL query to calculate the average sales for each month of each year?**:
```sql
SELECT 
       YEAR(order_date) AS sales_year,
       MONTH(order_date) AS sales_month,
       AVG(total_price) AS total_sales
FROM pizza_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY sales_year, sales_month;
```

22. **Write an SQL query to calculate the total sales for each day of the week?**:
```sql
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

```

23. **Write an SQL query to find the peak order hours by counting the number of orders placed for each hour of the day?**:
```sql
SELECT 
       HOUR(order_time) AS Order_Hour,
       COUNT(order_id) AS Order_Count
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY Order_Count DESC;
```

24. **Write an SQL query to find the order acquistion rate?**:
```sql
SELECT 
       YEAR(order_date) AS Order_year,
       COUNT(DISTINCT order_id) AS new_order
FROM pizza_sales
WHERE order_date BETWEEN '2015-01-01' AND CURDATE()
GROUP BY YEAR(order_date);

```

25. **Write an SQL query to calculate the sales for each day, the sales from the previous day, and the day-over-day changes in sales?**:
```sql
SELECT 
      order_date,
      total_price,
      LAG(total_price, 1) OVER (ORDER BY order_date) AS previous_day_sales,
      total_price - COALESCE(LAG(total_price, 1) OVER (ORDER BY order_date), 0) AS daily_changes
FROM pizza_sales
ORDER BY order_date;
```


## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Abdur Rehman

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:


- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/abdurrehmanfarooqui/)
- **Discord**: [Join our community to learn and grow together](https://discord.gg/abdurrehman0923)

Thank you for your support, and I look forward to connecting with you!
