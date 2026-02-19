\echo ''
\echo '===================================================='
\echo '                SALES & REVENUE ANALYSIS'
\echo '===================================================='

\pset title 'Q1: What are the monthly revenue trends for the last two years?'
SELECT
    DATE_TRUNC('month', invoice_date) AS month,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM sales_fact
GROUP BY month
ORDER BY month;

\pset title ''