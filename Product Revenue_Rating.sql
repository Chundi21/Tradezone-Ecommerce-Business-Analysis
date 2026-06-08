--Q7

WITH product_ratings AS (
    SELECT
        r.product_id,
        ROUND(AVG(r.rating), 2) AS avg_rating
    FROM reviews r
    WHERE r.rating IS NOT NULL
    GROUP BY r.product_id
--Average product rating
),
product_revenue AS (
    SELECT
        oi.product_id,
        ROUND(SUM(oi.line_total), 2) AS total_revenue
    FROM order_items oi
    WHERE oi.line_total IS NOT NULL
    AND oi.line_total > 0
    GROUP BY oi.product_id
--Total revenue per product
),
categorized AS (
    SELECT
        p.product_id,
        p.unit_price,
        pr.avg_rating,
        pv.total_revenue,
        CASE
            WHEN pr.avg_rating >= 4.0 THEN 'High Rated'
            WHEN pr.avg_rating >= 3.0 THEN 'Mid Rated'
            ELSE 'Low Rated'
        END AS rating_category
    FROM products p
    JOIN product_ratings pr ON p.product_id = pr.product_id
    LEFT JOIN product_revenue pv ON p.product_id = pv.product_id
-- joining ratings and revenue, categorizing the ratings
)
SELECT
    rating_category,
    COUNT(product_id) AS product_count,
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    ROUND(AVG(unit_price), 2) AS avg_unit_price
FROM categorized
GROUP BY rating_category
ORDER BY total_revenue DESC;










