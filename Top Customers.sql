
--Q1

WITH new_signups_2024 AS (
    SELECT 
        customer_id,state,signup_date
    FROM customers
    WHERE EXTRACT(YEAR FROM signup_date) = 2024
),
--customers who signed up in 2024
conversions AS (
    SELECT 
        ns.customer_id,
        ns.state,
        ns.signup_date,
        CASE 
            WHEN MIN(o.order_date) <= ns.signup_date + INTERVAL '30 days'
            THEN 1 
            ELSE 0 
        END AS converted
    FROM new_signups_2024 ns
    LEFT JOIN orders o 
        ON ns.customer_id = o.customer_id
        AND o.order_date >= ns.signup_date
    GROUP BY ns.customer_id, ns.state, ns.signup_date
)
 -- new customerS who placed an order within 30 days of signing up
SELECT
    state,
    COUNT(*) AS total_signups,
    SUM(converted) AS converted_customers,
    ROUND(
        SUM(converted) * 100.0 / COUNT(*), 2
    ) AS conversion_rate_pct
FROM conversions
GROUP BY state
ORDER BY total_signups DESC
LIMIT 5;