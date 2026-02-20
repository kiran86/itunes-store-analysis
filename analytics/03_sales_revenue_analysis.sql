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

\pset title 'Q2: What is the average value of an invoice (purchase)?'

SELECT
    ROUND(AVG(total), 2) AS average_invoice_value
FROM invoice;

\pset title ''

\pset title 'Q3: Which payment methods are used most frequently?'

SELECT
    payment_method,
    COUNT(*) AS usage_count
FROM payment
GROUP BY payment_method
ORDER BY usage_count DESC;

\pset title 'Q4: How much revenue does each sales representative contribute?'

