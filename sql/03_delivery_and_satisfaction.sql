-- Delivery and Satisfaction Analysis
-- Objective: Measure late-delivery frequency and assess its association
-- with customer review scores.
--
-- Scope: Delivered orders with non-null actual and estimated delivery dates.
-- Note: The results show an association, not proof that delivery delays
-- directly caused lower review scores.

-- 3. delivery and satisfaction
-- 3-1. Late delivery rate
WITH classified_orders AS(
SELECT
  CASE
    WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 'On time'
    ELSE 'Late'
  END AS delivery_status
FROM wagon-bootcamp-503804.Olist.orders
WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NOT NULL
AND order_estimated_delivery_date IS NOT NULL
)

SELECT
delivery_status
, COUNT(*) AS order_count
, ROUND(COUNT(*) / SUM(COUNT(*)) OVER () * 100, 2) AS order_share_pct
FROM classified_orders
GROUP BY delivery_status;

-- 3-2. Do late deliveries receive lower review scores?
WITH classified_orders AS(
SELECT
order_id
,  CASE
    WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 'On time'
    ELSE 'Late'
  END AS delivery_status
FROM wagon-bootcamp-503804.Olist.orders
WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NOT NULL
AND order_estimated_delivery_date IS NOT NULL
)

, review_by_order AS(
SELECT
order_id
, AVG(review_score) AS review_score
FROM wagon-bootcamp-503804.Olist.order_reviews
WHERE review_score IS NOT NULL
GROUP BY order_id
)

SELECT
c.delivery_status
, COUNT(*) AS reviewed_orders
, ROUND(AVG(review_score), 2) AS avg_review_score
FROM classified_orders AS c
INNER JOIN review_by_order AS r
USING(order_id)
GROUP BY c.delivery_status;
