\echo ''
\echo '===================================================='
\echo '                 GEOGRAPHIC TRENDS'
\echo '===================================================='
\echo ''

\pset title 'Q1.a: Which countries have the highest number of customers?'

SELECT
    country,
    COUNT(*) AS total_customers
FROM customer
GROUP BY country
ORDER BY total_customers DESC;

\pset title ''

\pset title 'Q1.b: Which cities have the highest number of customers?'

SELECT
    city,
    country,
    COUNT(*) AS total_customers
FROM customer
GROUP BY city, country
ORDER BY total_customers DESC
LIMIT 10;

\pset title ''

\pset title 'Q2: How does revenue vary by region (country)?'

SELECT
    country,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM sales_fact
GROUP BY country
ORDER BY total_revenue DESC;

\pset title ''

\pset title 'Q2_alt: Revenue per Customer by Country'

SELECT
    country,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(SUM(revenue) / COUNT(DISTINCT customer_id), 2) AS revenue_per_customer
FROM sales_fact
GROUP BY country
ORDER BY revenue_per_customer DESC;

\pset title ''

\pset title 'Q3: Are there any underserved geographic regions (high users, low sales)?'

WITH regional_stats AS (
    SELECT
        country,
        COUNT(DISTINCT customer_id) AS total_customers,
        SUM(revenue) AS total_revenue,
        SUM(revenue) / COUNT(DISTINCT customer_id) AS revenue_per_customer
    FROM sales_fact
    GROUP BY country
)
SELECT
    country,
    total_customers,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(revenue_per_customer, 2) AS revenue_per_customer
FROM regional_stats
ORDER BY total_customers DESC, revenue_per_customer ASC;

\pset title 'Extra: Revenue Share by Country (%)'

WITH country_revenue AS (
    SELECT
        country,
        SUM(revenue) AS total_revenue
    FROM sales_fact
    GROUP BY country
),
total AS (
    SELECT SUM(total_revenue) AS overall FROM country_revenue
)
SELECT
    cr.country,
    ROUND(cr.total_revenue, 2) AS total_revenue,
    ROUND((cr.total_revenue / t.overall) * 100, 2) AS revenue_share_percent
FROM country_revenue cr, total t
ORDER BY total_revenue DESC;

\pset title ''