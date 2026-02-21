\echo ''
\echo '===================================================='
\echo '        CUSTOMER RETENTION & PURCHASE PATTERNS'
\echo '===================================================='
\echo ''

\pset title 'Q1: What is the distribution of purchase frequency per customer?'

WITH purchase_frequency AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice_id) AS total_orders
    FROM sales_fact
    GROUP BY customer_id
)
SELECT
    total_orders,
    COUNT(*) AS number_of_customers
FROM purchase_frequency
GROUP BY total_orders
ORDER BY total_orders;

\pset title ''

\pset title 'Q2: How long is the average time between customer purchases?'

WITH customer_purchase_intervals AS (
    SELECT
        customer_id,
        invoice_date,
        LAG(invoice_date) OVER (
            PARTITION BY customer_id
            ORDER BY invoice_date
        ) AS previous_purchase_date
    FROM invoice
),
intervals AS (
    SELECT
        customer_id,
        invoice_date - previous_purchase_date AS days_between
    FROM customer_purchase_intervals
    WHERE previous_purchase_date IS NOT NULL
)
SELECT
    ROUND(AVG(days_between), 2) AS avg_days_between_purchases
FROM intervals;

\pset title ''

\pset title 'Q3: What percentage of customers purchase tracks from more than one genre?'

WITH customer_genre_count AS (
    SELECT
        customer_id,
        COUNT(DISTINCT genre_id) AS genre_count
    FROM sales_fact
    GROUP BY customer_id
),
summary AS (
    SELECT
        COUNT(*) AS total_customers,
        SUM(CASE WHEN genre_count > 1 THEN 1 ELSE 0 END) AS multi_genre_customers
    FROM customer_genre_count
)
SELECT
    total_customers,
    multi_genre_customers,
    ROUND(
        (multi_genre_customers::numeric / total_customers) * 100,
        2
    ) AS percentage_multi_genre
FROM summary;

\pset title ''

\pset title 'Extra: Customer Segmentation by Purchase Frequency'

WITH purchase_frequency AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice_id) AS total_orders
    FROM sales_fact
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-time'
        WHEN total_orders BETWEEN 2 AND 4 THEN 'Occasional'
        ELSE 'Frequent'
    END AS customer_segment,
    COUNT(*) AS customer_count
FROM purchase_frequency
GROUP BY customer_segment
ORDER BY customer_count DESC;

\pset title ''