\echo ''
\echo '===================================================='
\echo '             ARTIST & GENRE PERFORMANCE'
\echo '===================================================='
\echo ''
\echo ''

\pset title 'Q1: Who are the top 5 highest-grossing artists?'

SELECT
    ar.artist_id,
    ar.name AS artist_name,
    ROUND(SUM(sf.revenue), 2) AS total_revenue
FROM sales_fact sf
JOIN track t ON t.track_id = sf.track_id
JOIN album al ON al.album_id = t.album_id
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY ar.artist_id, artist_name
ORDER BY total_revenue DESC
LIMIT 5;

\pset title ''

\pset title 'Q2.a: Which music genres are most popular in terms of number of tracks sold?'

SELECT
    g.name AS genre,
    SUM(sf.quantity) AS total_units_sold
FROM sales_fact sf
JOIN genre g ON g.genre_id = sf.genre_id
GROUP BY genre
ORDER BY total_units_sold DESC;

\pset title ''

\pset title 'Q2.b: Which music genres are most popular in terms of total revenue?'

SELECT
    g.name AS genre,
    ROUND(SUM(sf.revenue), 2) AS total_revenue
FROM sales_fact sf
JOIN genre g ON g.genre_id = sf.genre_id
GROUP BY genre
ORDER BY total_revenue DESC;

\pset title ''

\pset title 'Q3: Are certain genres more popular in specific countries?'

WITH country_genre_sales AS (
    SELECT
        sf.country,
        g.name AS genre,
        SUM(sf.revenue) AS total_revenue
    FROM sales_fact sf
    JOIN genre g ON g.genre_id = sf.genre_id
    GROUP BY sf.country, genre
),
ranked AS (
    SELECT
        country,
        genre,
        ROUND(total_revenue, 2) AS total_revenue,
        RANK() OVER (
            PARTITION BY country
            ORDER BY total_revenue DESC
        ) AS revenue_rank
    FROM country_genre_sales
)
SELECT
    country,
    genre,
    total_revenue
FROM ranked
WHERE revenue_rank = 1
ORDER BY total_revenue DESC;

\pset title ''