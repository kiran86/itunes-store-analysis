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
LIMIT 1;

\pset title ''

\pset title 'Q2: What is the average customer lifetime value?'

SELECT
    ROUND(AVG(total_revenue), 2) AS avg_customer_lifetime_value
FROM customer_summary;

\pset title ''

\pset title 'Q3: How many customers have made repeat purchases versus one-time purchases?'

SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM customer_summary
GROUP BY customer_type
ORDER BY customer_type;

\pset title ''
