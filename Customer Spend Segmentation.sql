
--Q5
--Customer Spend Segmentation

WITH customer_spend AS (
    SELECT
        o.customer_id,
        SUM(o.total_amount) AS total_spend
    FROM orders o
    WHERE EXTRACT(YEAR FROM o.order_date) = 2024
    AND o.order_status NOT IN ('Cancelled', 'Returned')
    AND o.total_amount IS NOT NULL
    AND o.total_amount > 0
    GROUP BY o.customer_id
),
segmented AS (
    SELECT
        customer_id,
        total_spend,
        CASE
            WHEN total_spend >= 100000 THEN 'Top Spenders'
            WHEN total_spend >= 50000  THEN 'Average Spenders'
            ELSE 'Lowest Spenders'
        END AS segment
    FROM customer_spend
)
SELECT
    segment,
    COUNT(customer_id) AS customer_count,
    ROUND(AVG(total_spend), 2) AS avg_spend_per_customer,
    ROUND(SUM(total_spend), 2) AS total_revenue_contribution
FROM segmented
GROUP BY segment
ORDER BY total_revenue_contribution DESC;










