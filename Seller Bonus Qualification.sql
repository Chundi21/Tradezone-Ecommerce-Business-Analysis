--Q8

--Top Seller Bonus Qualification
WITH seller_revenue AS (
    SELECT
        o.seller_id,
        COUNT(o.order_id) AS total_orders,
        ROUND(SUM(o.total_amount), 2) AS total_revenue
    FROM orders o
    WHERE EXTRACT(YEAR FROM o.order_date) = 2024
    AND o.order_status NOT IN ('Cancelled', 'Returned')
    AND o.total_amount IS NOT NULL
    AND o.total_amount > 0
    GROUP BY o.seller_id
    HAVING COUNT(o.order_id) >= 10
),
seller_ratings AS (
    SELECT
        p.seller_id,
        ROUND(AVG(r.rating), 2) AS avg_rating
    FROM reviews r
    JOIN products p ON r.product_id = p.product_id
    WHERE r.rating IS NOT NULL
    GROUP BY p.seller_id
)
SELECT
    s.seller_name,
    sr.total_orders,
    srat.avg_rating,
    sr.total_revenue
FROM seller_revenue sr
JOIN sellers s ON sr.seller_id = s.seller_id
JOIN seller_ratings srat ON sr.seller_id = srat.seller_id
WHERE srat.avg_rating >= 4.0
ORDER BY sr.total_revenue DESC
LIMIT 10;

















