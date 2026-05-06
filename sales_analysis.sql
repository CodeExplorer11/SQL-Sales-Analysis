-- Create Database
CREATE DATABASE sales_analysis;
USE sales_analysis;

-- Create Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    region VARCHAR(50)
);

-- Create Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- Create Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create Sales Table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert Data into Customers
INSERT INTO customers VALUES
(1, 'Rahul Sharma', 'Delhi', 'North'),
(2, 'Priya Singh', 'Mumbai', 'West'),
(3, 'Aman Verma', 'Lucknow', 'North'),
(4, 'Sneha Patel', 'Ahmedabad', 'West'),
(5, 'Arjun Reddy', 'Hyderabad', 'South'),
(6, 'Kavya Iyer', 'Chennai', 'South'),
(7, 'Rohan Das', 'Kolkata', 'East'),
(8, 'Anjali Mehta', 'Jaipur', 'North');

-- Insert Data into Products
INSERT INTO products VALUES
(101, 'Laptop', 'Technology', 75000),
(102, 'Smartphone', 'Technology', 30000),
(103, 'Office Chair', 'Furniture', 12000),
(104, 'Desk', 'Furniture', 18000),
(105, 'Printer', 'Office Supplies', 15000),
(106, 'Notebook Pack', 'Office Supplies', 500),
(107, 'Monitor', 'Technology', 20000),
(108, 'Bookshelf', 'Furniture', 10000);

-- Insert Data into Orders
INSERT INTO orders VALUES
(1001, 1, '2025-01-10'),
(1002, 2, '2025-01-15'),
(1003, 3, '2025-02-05'),
(1004, 4, '2025-02-12'),
(1005, 5, '2025-03-01'),
(1006, 6, '2025-03-08'),
(1007, 7, '2025-03-15'),
(1008, 8, '2025-04-02');

-- Insert Data into Sales
INSERT INTO sales VALUES
(1, 1001, 101, 1, 75000),
(2, 1001, 106, 3, 1500),
(3, 1002, 102, 1, 30000),
(4, 1002, 105, 1, 15000),
(5, 1003, 103, 2, 24000),
(6, 1004, 104, 1, 18000),
(7, 1005, 107, 2, 40000),
(8, 1006, 108, 1, 10000),
(9, 1007, 101, 1, 75000),
(10, 1008, 102, 2, 60000);

-- Display Tables
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM sales;

-- Total Revenue
SELECT SUM(total_amount) AS total_revenue
FROM sales;

-- Top Selling Products
SELECT p.product_name,
       SUM(s.quantity) AS total_quantity
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC;

-- Best Customers
SELECT c.customer_name,
       SUM(s.total_amount) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN sales s
ON o.order_id = s.order_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- Regional Sales Analysis
SELECT c.region,
       SUM(s.total_amount) AS regional_sales
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN sales s
ON o.order_id = s.order_id
GROUP BY c.region;

-- Average Order Value
SELECT AVG(total_amount) AS avg_order_value
FROM sales;

-- Monthly Revenue Analysis
SELECT MONTH(order_date) AS month,
       SUM(total_amount) AS revenue
FROM orders o
JOIN sales s
ON o.order_id = s.order_id
GROUP BY month
ORDER BY revenue DESC;