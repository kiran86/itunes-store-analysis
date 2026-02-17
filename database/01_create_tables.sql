-- SQL script to define schema for the itunes store database
CREATE TABLE artist (
    artist_id INTEGER PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE album (
    album_id INTEGER PRIMARY KEY,
    title VARCHAR(255),
    artist_id INTEGER
);

CREATE TABLE genre (
    genre_id INTEGER PRIMARY KEY,
    name VARCHAR(120)
);

CREATE TABLE media_type (
    media_type_id INTEGER PRIMARY KEY,
    name VARCHAR(120)
);

CREATE TABLE track (
    track_id INTEGER PRIMARY KEY,
    name VARCHAR(200),
    album_id INTEGER,
    media_type_id INTEGER,
    genre_id INTEGER,
    composer VARCHAR(255),
    milliseconds INTEGER,
    bytes INTEGER,
    unit_price NUMERIC(10,2)
);

CREATE TABLE playlist (
    playlist_id INTEGER PRIMARY KEY,
    name VARCHAR(120)
);

CREATE TABLE playlist_track (
    playlist_id INTEGER,
    track_id INTEGER,
    PRIMARY KEY (playlist_id, track_id)
);

CREATE TABLE customer (
    customer_id INTEGER PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(20),
    company VARCHAR(80),
    address VARCHAR(70),
    city VARCHAR(40),
    state VARCHAR(40),
    country VARCHAR(40),
    postal_code VARCHAR(10),
    phone VARCHAR(24),
    fax VARCHAR(24),
    email VARCHAR(60),
    support_rep_id INTEGER
);

CREATE TABLE employee (
    employee_id INTEGER PRIMARY KEY,
    last_name VARCHAR(20),
    first_name VARCHAR(20),
    title VARCHAR(30),
    reports_to INTEGER,
    levels VARCHAR(2),
    birth_date TIMESTAMP,
    hire_date TIMESTAMP,
    address VARCHAR(70),
    city VARCHAR(40),
    state VARCHAR(40),
    country VARCHAR(40),
    postal_code VARCHAR(10),
    phone VARCHAR(24),
    fax VARCHAR(24),
    email VARCHAR(60)
);

CREATE TABLE invoice (
    invoice_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    invoice_date TIMESTAMP,
    billing_address VARCHAR(70),
    billing_city VARCHAR(40),
    billing_state VARCHAR(40),
    billing_country VARCHAR(40),
    billing_postal_code VARCHAR(10),
    total NUMERIC(10,2)
);

CREATE TABLE invoice_line (
    invoice_line_id INTEGER PRIMARY KEY,
    invoice_id INTEGER,
    track_id INTEGER,
    unit_price NUMERIC(10,2),
    quantity INTEGER
);
