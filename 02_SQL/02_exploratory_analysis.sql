-- ======================================================
-- Exploratory Data Analysis
-- ======================================================

-- Total Customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Total Orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Total Sellers
SELECT COUNT(*) AS total_sellers
FROM sellers;

-- Total Products
SELECT COUNT(*) AS total_products
FROM products;

-- Order Status Distribution
SELECT order_status,
COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Payment Method Distribution
SELECT payment_type,
COUNT(*) AS total_transactions
FROM order_payments
GROUP BY payment_type
ORDER BY total_transactions DESC;
