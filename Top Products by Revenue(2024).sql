--Q2

--Finding the top 10 products by revenue focusing on the year 2024
SELECT
    p.product_name,
    p.category,
    ROUND(SUM(oi.line_total), 2) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2024
AND o.order_status NOT IN ('Cancelled', 'Returned')
AND oi.line_total IS NOT NULL
GROUP BY p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 10;







