--Q4


--Quarterly Revenue Trends
WITH quarterly_revenue AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS year,
        EXTRACT(QUARTER FROM order_date) AS quarter,
        ROUND(SUM(total_amount), 2) AS total_revenue,
        ROUND(AVG(total_amount), 2) AS avg_order_value,
        COUNT(order_id) AS total_orders
    FROM orders
    WHERE order_status NOT IN ('Cancelled', 'Returned')
    AND total_amount IS NOT NULL
    AND total_amount > 0
    GROUP BY year, quarter
),
growth AS (
    SELECT
        curr.quarter AS quarter,
        curr.year AS current_year,
        curr.total_revenue AS current_revenue,
        prev.total_revenue AS previous_revenue,
        ROUND(
            (curr.total_revenue - prev.total_revenue)
            * 100.0 / prev.total_revenue, 2
        )                                      AS growth_pct
    FROM quarterly_revenue curr
    JOIN quarterly_revenue prev
        ON curr.quarter = prev.quarter
        AND curr.year = prev.year + 1
)
--Top Performing Quarter
SELECT
    quarter,
    current_revenue,
    previous_revenue,
    growth_pct
FROM growth
ORDER BY growth_pct DESC
LIMIT 1;




