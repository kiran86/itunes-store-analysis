\echo ''
\echo '===================================================='
\echo '                SALES & REVENUE ANALYSIS'
\echo '===================================================='

\pset title 'Q1: What are the monthly revenue trends for the last two years?'
SELECT
    DATE_TRUNC('month', invoice_date) AS month,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM sales_fact
WHERE invoice_date >= (SELECT MAX(invoice_date) - INTERVAL '2 years' FROM sales_fact)
GROUP BY month
ORDER BY month;

\pset title ''

\pset title 'Q2: What is the average value of an invoice (purchase)?'

SELECT
    ROUND(AVG(total), 2) AS average_invoice_value
FROM invoice;

\pset title ''

\pset title 'Q4: How much revenue does each sales representative contribute?'

SELECT
    e.first_name || ' ' || e.last_name AS support_rep_name,
    ROUND(COALESCE(SUM(sf.revenue), 0), 2) AS total_revenue
FROM employee e
LEFT JOIN sales_fact sf ON sf.support_rep_id = e.employee_id
GROUP BY support_rep_name
ORDER BY total_revenue DESC;

\pset title ''

\pset title 'Q5: Which months have peak music sales?'

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', invoice_date)::date AS month,
        ROUND(SUM(revenue), 2) AS total_revenue
    FROM sales_fact
    GROUP BY month
)
SELECT
    month,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM monthly_sales
ORDER BY revenue_rank;

\pset title ''

\pset title 'Q6: Which quarters have peak music sales?'

WITH quarterly_sales AS (
    SELECT
        EXTRACT(YEAR FROM invoice_date) AS year,
        EXTRACT(QUARTER FROM invoice_date) AS quarter,
        ROUND(SUM(revenue), 2) AS total_revenue
    FROM sales_fact
    GROUP BY year, quarter
)
SELECT
    year,
    quarter,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM quarterly_sales
ORDER BY revenue_rank;

\pset title ''