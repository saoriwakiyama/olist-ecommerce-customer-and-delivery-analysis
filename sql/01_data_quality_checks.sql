-- Data Quality Checks
-- Objective: Validate order status, delivery-date completeness,
-- and order-level uniqueness before analysis.

-- 1. Check the distribution of order statuses
SELECT  
order_status
, COUNT(*) AS order_count
FROM `wagon-bootcamp-503804.Olist.orders`
GROUP BY order_status
ORDER BY order_count DESC;

-- 2. Check missing delivery timestamps
SELECT 
COUNT(*) AS delivered_orders
, COUNTIF(order_approved_at IS NULL) AS missing_approval
, COUNTIF(order_delivered_carrier_date IS NULL) AS missing_carrier_date
, COUNTIF(order_delivered_customer_date IS NULL) AS missing_delivery_date
, COUNTIF(order_estimated_delivery_date IS NULL) AS missing_estimated_date
FROM `wagon-bootcamp-503804.Olist.orders`
WHERE order_status = 'delivered';

-- 3. Check order_id uniqueness
SELECT
COUNT(*) AS nb
FROM `wagon-bootcamp-503804.Olist.orders`
GROUP BY order_id
HAVING nb >= 2;