\echo ''
\echo '===================================================='
\echo '                 CUSTOMER ANALYTICS'
\echo '===================================================='

\pset title 'Q1: Which customers have spent the most money on music?'

SELECT
    c.first_name || ' ' || c.last_name AS customer_name,
    ROUND(SUM(sf.revenue), 2) AS total_spent
FROM sales_fact sf
JOIN customer c ON c.customer_id = sf.customer_id
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 10;

\pset title ''

\pset title 'Q2: What is the average customer lifetime value?'

SELECT
    ROUND(AVG(total_revenue), 2) AS avg_customer_lifetime_value
FROM customer_summary;

\pset title ''

\pset title 'Q3: How many customers have made repeat purchases versus one-time purchases?'

WITH customer_types AS (
    SELECT 'One-time' AS customer_type
    UNION ALL
    SELECT 'Repeat'
)
SELECT
    ct.customer_type,
    COALESCE(COUNT(cs.total_orders), 0) AS customer_count
FROM customer_types ct
LEFT JOIN customer_summary cs
    ON ct.customer_type =
    CASE
        WHEN cs.total_orders = 1 THEN 'One-time'
        ELSE 'Repeat'
    END
GROUP BY ct.customer_type
ORDER BY ct.customer_type;

\pset title ''

\pset title 'Q4: Which country generates the most revenue per customer?'
SELECT
    country,
    ROUND(SUM(revenue) / COUNT(DISTINCT customer_id), 2) AS revenue_per_customer
FROM sales_fact
GROUP BY country
ORDER BY revenue_per_customer DESC
LIMIT 1;

\pset title ''

\pset title 'Q5: Which customers haven not made a purchase in the last 6 months?'

SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    cs.last_purchase_date
FROM customer_summary cs
JOIN customer c ON c.customer_id = cs.customer_id
WHERE cs.last_purchase_date < (
    SELECT MAX(invoice_date) FROM invoice
) - INTERVAL '6 months'
ORDER BY cs.last_purchase_date;

\pset title ''
