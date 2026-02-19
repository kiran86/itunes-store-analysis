\echo ''
\echo '=========================================='
\echo '   iTunes Business Analytics Execution'
\echo '=========================================='

\i analytics/01_base_views.sql
\i analytics/02_customer_analytics.sql
\i analytics/03_sales_revenue_analysis.sql
-- \i 04_product_analytics.sql
-- \i 05_artist_genre_analytics.sql
-- \i 06_employee_analytics.sql
-- \i 07_geographic_analytics.sql
-- \i 08_retention_analytics.sql

\echo ''
\echo '=========================================='
\echo '        All Analysis Completed'
\echo '=========================================='
