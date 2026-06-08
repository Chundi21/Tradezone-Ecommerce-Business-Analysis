--Q3

--Identifying the top sellers by fulfillment efficiency
WITH seller_fulfilment AS (
    SELECT
        o.seller_id,
        (o.delivery_date - o.order_date) * 24  AS fulfilment_hours
    FROM orders o
    WHERE o.order_status = 'Delivered'
    AND o.delivery_date IS NOT NULL
    AND o.order_date IS NOT NULL
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
    COUNT(sf.fulfilment_hours) AS completed_orders,
    ROUND(AVG(sf.fulfilment_hours), 2) AS avg_fulfilment_hours,
    sr.avg_rating
FROM seller_fulfilment sf
JOIN sellers s ON sf.seller_id = s.seller_id
LEFT JOIN seller_ratings sr ON sf.seller_id = sr.seller_id
GROUP BY s.seller_name, sr.avg_rating
HAVING COUNT(sf.fulfilment_hours) >= 20
ORDER BY avg_fulfilment_hours ASC
LIMIT 20;


















