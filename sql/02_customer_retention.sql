-- Customer Retention Analysis
-- Objective: Compare customer frequency and item-sales contribution
-- between one-time and repeat customers.
--
-- Scope: Delivered orders only.
-- Note: This measures repeat purchases observed within the dataset period,
-- not a customer's lifetime repeat rate.

-- 2. Customer Retention
-- 2-1. Orders per customer
WITH customer_orders AS(
  SELECT
  c.customer_unique_id
  , COUNT(DISTINCT o.order_id) AS order_count
  FROM wagon-bootcamp-503804.Olist.customers AS c
  INNER JOIN wagon-bootcamp-503804.Olist.orders AS o
  USING(customer_id)
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
)

SELECT
order_count
, COUNT(*) AS customer_count
FROM customer_orders
GROUP BY order_count
ORDER BY order_count;

-- 2-2. Repeat customer rate
WITH customer_orders AS(
  SELECT
  c.customer_unique_id
  , COUNT(DISTINCT o.order_id) AS order_count
  FROM wagon-bootcamp-503804.Olist.customers AS c
  INNER JOIN wagon-bootcamp-503804.Olist.orders AS o
  USING(customer_id)
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
)

SELECT
COUNT(*) AS total_customers
, COUNTIF(order_count = 1) AS one_time_customers
, COUNTIF(order_count > 1) AS repeat_customers
, ROUND(COUNTIF(order_count > 1)/COUNT(*)*100, 2) AS repeat_customer_rate_pct
FROM customer_orders;

-- 2-3. Sales contribution by customer type
WITH customer_orders AS(
  SELECT
  c.customer_unique_id
  , COUNT(DISTINCT o.order_id) AS order_count
  , SUM(oi.price) AS customer_item_sales
  FROM wagon-bootcamp-503804.Olist.customers AS c
  INNER JOIN wagon-bootcamp-503804.Olist.orders AS o
  USING(customer_id)
  INNER JOIN wagon-bootcamp-503804.Olist.order_items AS oi
  USING(order_id)
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
)

, customer_segment AS(
  SELECT
  customer_unique_id
  , order_count
  , customer_item_sales
  , CASE
      WHEN order_count = 1 THEN 'One-time'
      ELSE 'Repeat'
    END AS customer_type
  FROM customer_orders
)

SELECT
customer_type
, COUNT(*) AS customer_count
, SUM(order_count) AS delivered_orders
, ROUND(SUM(customer_item_sales), 2) AS total_item_sales
, ROUND(SUM(customer_item_sales)/SUM(SUM(customer_item_sales))OVER()*100, 2) AS sales_share_pct
FROM customer_segment
GROUP BY customer_type;
