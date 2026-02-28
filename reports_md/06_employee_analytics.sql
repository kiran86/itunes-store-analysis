\echo ''
\echo '===================================================='
\echo '         EMPLOYEE & OPERATIONAL EFFICIENCY'
\echo '===================================================='
\echo ''

\pset title 'Q1: Which employees (support representatives) are managing the highest-spending customers?'

SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    ROUND(SUM(sf.revenue), 2) AS total_customer_revenue
FROM employee e
JOIN customer c ON c.support_rep_id = e.employee_id
JOIN sales_fact sf ON sf.customer_id = c.customer_id
GROUP BY e.employee_id, employee_name
ORDER BY total_customer_revenue DESC;

\pset title ''

\pset title 'Q2: Average Revenue per Customer Managed'

SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    ROUND(
        SUM(sf.revenue) / COUNT(DISTINCT c.customer_id),
        2
    ) AS avg_revenue_per_customer
FROM employee e
JOIN customer c ON c.support_rep_id = e.employee_id
JOIN sales_fact sf ON sf.customer_id = c.customer_id
GROUP BY e.employee_id, employee_name
ORDER BY avg_revenue_per_customer DESC;

\pset title ''

\pset title 'Q3: What is the average number of customers per employee?'

SELECT
    ROUND(AVG(customer_count), 2) AS avg_customers_per_employee
FROM (
    SELECT
        support_rep_id,
        COUNT(*) AS customer_count
    FROM customer
    GROUP BY support_rep_id
) sub;

\pset title ''

\pset title 'Q4: Which employee regions bring in the most revenue?'

SELECT
    e.country AS employee_country,
    ROUND(SUM(sf.revenue), 2) AS total_revenue
FROM employee e
JOIN customer c ON c.support_rep_id = e.employee_id
JOIN sales_fact sf ON sf.customer_id = c.customer_id
GROUP BY employee_country
ORDER BY total_revenue DESC;

\pset title ''

\pset title 'Q5: Employee Revenue Ranking'

WITH employee_revenue AS (
    SELECT
        e.employee_id,
        e.first_name || ' ' || e.last_name AS employee_name,
        SUM(sf.revenue) AS total_revenue
    FROM employee e
    JOIN customer c ON c.support_rep_id = e.employee_id
    JOIN sales_fact sf ON sf.customer_id = c.customer_id
    GROUP BY e.employee_id, employee_name
)
SELECT
    employee_name,
    ROUND(total_revenue, 2) AS total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM employee_revenue
ORDER BY revenue_rank;

\pset title ''