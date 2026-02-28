\echo ''
\echo '===================================================='
\echo '             PRODUCT & CONTENT ANALYSIS'
\echo '===================================================='

\pset title 'Q1: Which tracks generated the most revenue?'

SELECT
    t.track_id,
    t.name AS track_name,
    ar.name AS artist,
    ROUND(SUM(sf.revenue), 2) AS total_revenue
FROM sales_fact sf
JOIN track t ON t.track_id = sf.track_id
JOIN album al ON al.album_id = t.album_id
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY t.track_id, track_name, artist
ORDER BY total_revenue DESC
LIMIT 10;

\pset title ''

\pset title 'Q2.a: Which albums are most frequently included in purchases?'

SELECT
    al.title AS album_title,
    ar.name AS artist,
    SUM(sf.quantity) AS total_units_sold
FROM sales_fact sf
JOIN track t ON t.track_id = sf.track_id
JOIN album al ON al.album_id = t.album_id
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY album_title, artist
ORDER BY total_units_sold DESC
LIMIT 10;

\pset title ''

\pset title 'Q2.b: Which playlists are most frequently included in purchases?'

SELECT
    p.name AS playlist_name,
    COUNT(sf.track_id) AS purchased_tracks_count
FROM sales_fact sf
JOIN playlist_track pt ON pt.track_id = sf.track_id
JOIN playlist p ON p.playlist_id = pt.playlist_id
GROUP BY playlist_name
ORDER BY purchased_tracks_count DESC
LIMIT 10;

\pset title ''

\pset title 'Q3.a: Are there any tracks that have never been purchased?'

SELECT
    t.track_id,
    t.name AS track_name,
    ar.name AS artist
FROM track t
LEFT JOIN invoice_line il ON il.track_id = t.track_id
JOIN album al ON al.album_id = t.album_id
JOIN artist ar ON ar.artist_id = al.artist_id
WHERE il.track_id IS NULL
ORDER BY track_name;

\pset title ''

\pset title 'Q3.b: Are there any albums that have never been purchased?'

SELECT
    al.title AS album_title,
    ar.name AS artist
FROM album al
JOIN artist ar ON ar.artist_id = al.artist_id
LEFT JOIN track t ON t.album_id = al.album_id
LEFT JOIN invoice_line il ON il.track_id = t.track_id
GROUP BY album_title, artist
HAVING COUNT(il.invoice_line_id) = 0
ORDER BY album_title;

\pset title ''

\pset title 'Q4: What is the average price per track across different genres?'

SELECT
    g.name AS genre,
    ROUND(AVG(t.unit_price), 2) AS avg_track_price
FROM track t
JOIN genre g ON g.genre_id = t.genre_id
GROUP BY genre
ORDER BY avg_track_price DESC;

\pset title ''

\pset title 'Q5: How many tracks does the store have per genre and how does it correlate with sales?'

WITH genre_inventory AS (
    SELECT
        g.genre_id,
        g.name AS genre,
        COUNT(t.track_id) AS total_tracks
    FROM genre g
    LEFT JOIN track t ON t.genre_id = g.genre_id
    GROUP BY g.genre_id, genre
),
genre_sales AS (
    SELECT
        genre_id,
        SUM(revenue) AS total_revenue,
        SUM(quantity) AS total_units_sold
    FROM sales_fact
    GROUP BY genre_id
)
SELECT
    gi.genre,
    gi.total_tracks,
    COALESCE(gs.total_units_sold, 0) AS total_units_sold,
    ROUND(COALESCE(gs.total_revenue, 0), 2) AS total_revenue
FROM genre_inventory gi
LEFT JOIN genre_sales gs ON gs.genre_id = gi.genre_id
ORDER BY total_revenue DESC;

\pset title ''