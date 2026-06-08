--Q4

--Most Popular Payment Methods Across The Different States
WITH payment_by_state AS (
    SELECT
        c.state,
        p.payment_method,
        COUNT(p.payment_id) AS transaction_count,
        ROUND(SUM(p.amount), 2) AS total_amount
    FROM payments p
    JOIN orders o ON p.order_id = o.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    WHERE p.amount IS NOT NULL
    GROUP BY c.state, p.payment_method
),
ranked AS (
    SELECT
        state,
        payment_method,
        transaction_count,
        total_amount,
        RANK() OVER (
            PARTITION BY state 
            ORDER BY transaction_count DESC
        ) AS rank
    FROM payment_by_state
)
SELECT
    state,
    payment_method,
    transaction_count,
    total_amount,
    CASE WHEN rank = 1 THEN 'Most Popular Method' ELSE '' END AS popularity
FROM ranked
ORDER BY state, transaction_count DESC;















