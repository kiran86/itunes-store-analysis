\echo ''
\echo '===================================================='
\echo '             OPERATIONAL OPTIMIZATION'
\echo '===================================================='
\echo ''

\pset title 'Q1: What are the most common combinations of tracks purchased together?'

WITH track_pairs AS (
    SELECT
        a.track_id AS track_1,
        b.track_id AS track_2,
        COUNT(*) AS times_bought_together
    FROM invoice_line a
    JOIN invoice_line b
        ON a.invoice_id = b.invoice_id
        AND a.track_id < b.track_id
    GROUP BY a.track_id, b.track_id
)
SELECT
    t1.name AS track_1,
    t2.name AS track_2,
    times_bought_together
FROM track_pairs tp
JOIN track t1 ON t1.track_id = tp.track_1
JOIN track t2 ON t2.track_id = tp.track_2
ORDER BY times_bought_together DESC
LIMIT 10;

\pset title ''

\pset title 'Q2: Pricing Impact on Units Sold (Grouped by Price)'

SELECT
    t.unit_price,
    SUM(il.quantity) AS total_units_sold,
    ROUND(SUM(il.unit_price * il.quantity), 2) AS total_revenue
FROM track t
JOIN invoice_line il ON il.track_id = t.track_id
GROUP BY t.unit_price
ORDER BY t.unit_price;

\pset title 'Q2B: Sales by Price Tier'

WITH price_tiers AS (
    SELECT
        CASE
            WHEN unit_price < 0.99 THEN 'Low'
            WHEN unit_price BETWEEN 0.99 AND 1.49 THEN 'Medium'
            ELSE 'High'
        END AS price_category,
        quantity,
        unit_price
    FROM invoice_line
)
SELECT
    price_category,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(quantity * unit_price), 2) AS total_revenue
FROM price_tiers
GROUP BY price_category
ORDER BY total_revenue DESC;

\pset title ''

\pset title 'Q3: Which media types (e.g., MPEG, AAC) are declining or increasing in usage?'

WITH media_trend AS (
    SELECT
        EXTRACT(YEAR FROM i.invoice_date) AS year,
        mt.name AS media_type,
        SUM(il.quantity) AS total_units_sold
    FROM invoice i
    JOIN invoice_line il ON il.invoice_id = i.invoice_id
    JOIN track t ON t.track_id = il.track_id
    JOIN media_type mt ON mt.media_type_id = t.media_type_id
    GROUP BY year, media_type
)
SELECT
    year,
    media_type,
    total_units_sold
FROM media_trend
ORDER BY year, total_units_sold DESC;

\pset title ''

\pset title 'Q3B: Media Type Year-over-Year Change'

WITH media_trend AS (
    SELECT
        EXTRACT(YEAR FROM i.invoice_date) AS year,
        mt.name AS media_type,
        SUM(il.quantity) AS total_units_sold
    FROM invoice i
    JOIN invoice_line il ON il.invoice_id = i.invoice_id
    JOIN track t ON t.track_id = il.track_id
    JOIN media_type mt ON mt.media_type_id = t.media_type_id
    GROUP BY year, media_type
),
with_lag AS (
    SELECT
        year,
        media_type,
        total_units_sold,
        LAG(total_units_sold) OVER (
            PARTITION BY media_type
            ORDER BY year
        ) AS previous_year_sales
    FROM media_trend
)
SELECT
    year,
    media_type,
    total_units_sold,
    total_units_sold - previous_year_sales AS yearly_change
FROM with_lag
ORDER BY media_type, year;

\pset title ''