CREATE OR REPLACE VIEW sales_fact AS
SELECT
    i.invoice_id,
    i.invoice_date,
    c.customer_id,
    c.country,
    c.support_rep_id,
    il.track_id,
    t.genre_id,
    t.album_id,
    t.media_type_id,
    il.unit_price,
    il.quantity,
    (il.unit_price * il.quantity) AS revenue
FROM
    invoice i
JOIN
    invoice_line il ON i.invoice_id = il.invoice_id
JOIN
    customer c ON i.customer_id = c.customer_id
JOIN
    track t ON il.track_id = t.track_id;

CREATE OR REPLACE VIEW customer_summary AS
SELECT
    customer_id,
    COUNT(DISTINCT invoice_id) AS total_orders,
    SUM(revenue) AS total_revenue,
    AVG(revenue) AS avg_revenue_per_order,
    MAX(revenue) AS max_order_value,
    MAX(invoice_date) AS last_purchase_date
FROM
    sales_fact
GROUP BY
    customer_id;