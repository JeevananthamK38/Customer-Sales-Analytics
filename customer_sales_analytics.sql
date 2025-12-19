CREATE database customer_sales_analytics;
USE customer_sales_analytics;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    signup_date DATE
);
INSERT INTO customers VALUES
(1, 'Anita', 'Bangalore', '2020-01-15'),
(2, 'Rohit', 'Mumbai', '2019-06-10'),
(3, 'Suresh', 'Chennai', '2021-03-22'),
(4, 'Meena', 'Hyderabad', '2018-11-05'),
(5, 'Karthik', 'Pune', '2022-02-18');

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO orders VALUES
(101, 1, '2022-01-10', 12000),
(102, 1, '2022-03-15', 18000),
(103, 2, '2021-12-20', 25000),
(104, 2, '2022-02-11', 30000),
(105, 3, '2022-04-05', 9000),
(106, 4, '2021-10-10', 22000),
(107, 4, '2022-01-25', 28000);

SELECT * FROM customers;
SELECT * FROM orders;

# TASK 1: Customer Overview (Warm-up)
#1 .️Show all customers with total order amount
SELECT c.customer_name, sum(o.order_amount) as Total_order_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_name;

# 2.Customers who have placed more than one order
SELECT c.customer_name, count(o.order_id) as Total_orders_placed
FROM customers c
LEFT JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_name
HAVING count(o.order_id) >1; 

# 3. Customers who have never placed an order
SELECT c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id=o.customer_id
WHERE o.customer_id is NULL;

# 4. Classify customers based on total spending:
SELECT c.customer_name, sum(o.order_amount) as Total_spent,
CASE 
WHEN sum(o.order_amount) <20000 then 'Low Value'
WHEN sum(o.order_amount) BETWEEN 20000 AND 40000 Then 'Medium Value'
ELSE 'High Value'
END AS 'Customer_category'
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_name;

# Task 3 (Time-Based & Ranking Analysis)
# 5.Monthly total revenue
SELECT 
    MONTH(o.order_date) AS month,
    SUM(o.order_amount) AS total_revenue
FROM orders o
GROUP BY MONTH(o.order_date)
ORDER BY month;

# 6. Rank customers based on total spending
SELECT Customer_name, Total_spent,rank () over (order by Total_spent DESC) as Spent_rank
FROM (SELECT c.customer_name as Customer_name,sum(o.order_amount) as Total_spent
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_name)t;

# 7. Identify inactive customers
SELECT c.customer_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
    AND YEAR(o.order_date) = 2022
WHERE o.customer_id IS NULL;

# TASK 4
# 8. Identify Top 2 customers by total revenue
SELECT Customer_name, Total_revenue, Revenue_Rank
FROM (
    SELECT c.customer_name as Customer_name,
           SUM(o.order_amount) AS Total_revenue,
           RANK() OVER (ORDER BY SUM(o.order_amount) DESC) AS Revenue_Rank
    FROM customers c
    JOIN orders o 
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
) t
WHERE Revenue_Rank <= 2;

# 9.Contribution % of each customer to total revenue
SELECT customer_name, total_spent, round((total_spent/sum(total_spent) OVER())*100,2) AS contribution_percentage
FROM (
SELECT c.customer_name as customer_name, sum(o.order_amount) as total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name)t;




