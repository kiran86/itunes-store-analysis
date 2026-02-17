-- Create tables for the music store database
\echo 'Creating tables...'
\i database/01_create_tables.sql

-- Load data into tables
\echo 'Loading data into tables...'
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

-- Fix date formats in employee table
\echo 'Fixing date formats in employee table...'
\i database/02_fix_dates.sql

-- Add constraints to ensure data integrity
\echo 'Adding constraints...'
\i database/02_add_constraints.sql

-- Create indexes to improve query performance
\echo 'Creating indexes...'
\i database/03_create_indexes.sql

\echo 'Database build complete.'