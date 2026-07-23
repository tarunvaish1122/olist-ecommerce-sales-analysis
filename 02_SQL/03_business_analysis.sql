-- =====================================================
-- BUSINESS ANALYSIS
-- OLIST E-COMMERCE SALES ANALYSIS
-- =====================================================

-- ==========================================
-- BA-01 Total Revenue
-- ==========================================

SELECT
ROUND(SUM(price),2) AS total_revenue
FROM order_items;


-- ==========================================
-- BA-02 Monthly Revenue
-- ==========================================

SELECT
DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS month,
ROUND(SUM(oi.price),2) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY month
ORDER BY month;


-- ==========================================
-- BA-03 Monthly Revenue Growth
-- ==========================================

WITH monthly_sales AS
(
SELECT
DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS month,
SUM(oi.price) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY month
)

SELECT *,
LAG(revenue) OVER(ORDER BY month) AS previous_month_revenue
FROM monthly_sales;


-- ==========================================
-- BA-04 Top 10 Product Categories by Revenue
-- ==========================================

SELECT
pct.product_category_name_english,
ROUND(SUM(oi.price),2) AS revenue
FROM products p
JOIN product_category_name_translation pct
ON p.product_category_name=pct.product_category_name
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY pct.product_category_name_english
ORDER BY revenue DESC
LIMIT 10;


-- ==========================================
-- BA-05 Top 10 Sellers by Revenue
-- ==========================================

SELECT
seller_id,
ROUND(SUM(price),2) AS seller_revenue
FROM order_items
GROUP BY seller_id
ORDER BY seller_revenue DESC
LIMIT 10;


-- ==========================================
-- BA-06 Order Status Distribution
-- ==========================================

SELECT
order_status,
COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- ==========================================
-- BA-07 Payment Method Distribution
-- ==========================================

SELECT
payment_type,
COUNT(*) AS total_transactions
FROM order_payments
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- ==========================================
-- BA-08 Average Review Score
-- ==========================================

SELECT
ROUND(AVG(review_score),2) AS average_review_score
FROM order_reviews;


-- ==========================================
-- BA-09 Top 10 Highest Order Values
-- ==========================================

SELECT
order_id,
ROUND(SUM(price),2) AS order_value
FROM order_items
GROUP BY order_id
ORDER BY order_value DESC
LIMIT 10;
