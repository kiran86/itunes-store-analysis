# Apple iTunes Music Store -- SQL Analytics Project

## Project Overview

This project analyzes the Apple iTunes Music Store relational database
using PostgreSQL.

The objective is to extract actionable business insights related to:

-   Customer behavior
-   Revenue trends
-   Product performance
-   Artist & genre popularity
-   Employee efficiency
-   Geographic distribution
-   Customer retention
-   Operational optimization

All analysis is performed purely in SQL with a reproducible
Makefile-based execution workflow.

------------------------------------------------------------------------

## Tech Stack

-   PostgreSQL
-   SQL (CTEs, Window Functions, Aggregations)
-   Makefile (Execution Orchestration)
-   Environment-based configuration via `.env`

------------------------------------------------------------------------

## Project Structure

itunes-store-analysis/

├── data/\
│ └── CSV files

├── database/\
│ ├── 01_create_tables.sql\
│ ├── 02_fix_dates.sql\
│ ├── 03_add_constraints.sql\
│ ├── 04_create_indexes.sql\
│ └── run_all.sql

├── analytics/\
│ ├── 01_base_views.sql\
│ ├── 02_customer_analytics.sql\
│ ├── 03_sales_analytics.sql\
│ ├── 04_product_analytics.sql\
│ ├── 05_artist_genre_analytics.sql\
│ ├── 06_employee_analytics.sql\
│ ├── 07_geographic_analytics.sql\
│ ├── 08_retention_analytics.sql\
│ ├── 09_operational_optimization.sql\
│ └── run_all_analytics.sql

├── Makefile\
├── .env.example\
└── README.md

------------------------------------------------------------------------

## Setup Instructions

### 1. Configure Environment

Create a `.env` file:

DB_HOST=\
DB_PORT=\
DB_NAME=\
DB_USER=\
DB_PASSWORD=

Do not commit `.env` to GitHub.

------------------------------------------------------------------------

### 2. Build Database

Run:

```bash
make reset
```

This will:

-   Drop existing database (if any)
-   Recreate schema
-   Load CSV data
-   Fix date formats
-   Add constraints
-   Create indexes

------------------------------------------------------------------------

### 3. Run Full Analytics

Run:

```bash
make analysis
```

This executes all business analysis categories in a structured and
formatted manner.

------------------------------------------------------------------------

## Business Questions Answered

### Customer Analytics

-   Top spending customers
-   Average lifetime value
-   Repeat vs one-time customers
-   Inactive customers

### Sales & Revenue

-   Monthly and quarterly revenue trends
-   Peak sales periods
-   Revenue by country
-   Average invoice value

### Product & Content

-   Highest-grossing tracks
-   Most popular albums and playlists
-   Unsold tracks and albums
-   Price vs sales patterns

### Artist & Genre Performance

-   Top 5 highest-grossing artists
-   Genre popularity by revenue and volume
-   Country-level genre dominance

### Employee & Operational Efficiency

-   Revenue managed per support representative
-   Portfolio efficiency
-   Customer allocation balance

### Geographic Trends

-   Revenue by country
-   Revenue per customer
-   Identification of underserved regions

### Customer Retention & Purchase Patterns

-   Purchase frequency distribution
-   Average days between purchases
-   Multi-genre purchasing behavior

### Operational Optimization

-   Most common track combinations
-   Pricing tier impact
-   Media type growth and decline trends

------------------------------------------------------------------------

## SQL Techniques Used

-   Common Table Expressions (CTEs)
-   Window Functions (RANK, LAG)
-   Aggregations
-   Time-series analysis
-   Market basket analysis
-   Revenue ranking and segmentation

------------------------------------------------------------------------

## Key Strengths

-   Fully reproducible database build system
-   Environment-driven configuration
-   Modular SQL design
-   Clean separation of schema, transformation, constraints, and
    indexing
-   Structured business analytics workflow

------------------------------------------------------------------------

## Author

Kiran Sankar Das\
Data Analyst