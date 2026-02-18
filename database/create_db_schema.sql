-- Create tables for the music store database
\echo -n 'STEP 1/5: Creating tables...'
\i database/01_create_tables.sql
\echo 'DONE.'

-- Load data into tables
\echo -n 'STEP 2/5: Loading data into tables...'
\copy artist FROM 'data/artist.csv' DELIMITER ',' CSV HEADER;
\copy album FROM 'data/album.csv' DELIMITER ',' CSV HEADER;
\copy genre FROM 'data/genre.csv' DELIMITER ',' CSV HEADER;
\copy media_type FROM 'data/media_type.csv' DELIMITER ',' CSV HEADER;
\copy track FROM 'data/track.csv' DELIMITER ',' CSV HEADER;
\copy playlist FROM 'data/playlist.csv' DELIMITER ',' CSV HEADER;
\copy playlist_track FROM 'data/playlist_track.csv' DELIMITER ',' CSV HEADER;
\copy customer FROM 'data/customer.csv' DELIMITER ',' CSV HEADER;
\copy employee FROM 'data/employee.csv' DELIMITER ',' CSV HEADER;
\copy invoice FROM 'data/invoice.csv' DELIMITER ',' CSV HEADER;
\copy invoice_line FROM 'data/invoice_line.csv' DELIMITER ',' CSV HEADER;
\echo 'DONE.'

-- Fix date formats in employee table
\echo -n 'STEP 3/5: Fixing date formats in employee table...'
\i database/02_fix_dates.sql
\echo 'DONE.'

-- Add constraints to ensure data integrity
\echo -n 'STEP 4/5: Adding constraints...'
\i database/03_add_constraints.sql
\echo 'DONE.'

-- Create indexes to improve query performance
\echo -n 'STEP 5/5: Creating indexes...'
\i database/04_create_indexes.sql
\echo 'DONE.'

\echo 'Database build complete.'