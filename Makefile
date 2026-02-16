include .env
export

PSQL=psql -h $(DB_HOST) -p $(DB_PORT) -U $(DB_USER) -d $(DB_NAME)

build:
	@echo "Creating database schema..."
	$(PSQL) -f database/run_all.sql
	@echo "Build complete."

reset:
	@echo "Dropping and recreating database..."
	dropdb -h $(DB_HOST) -p $(DB_PORT) -U $(DB_USER) $(DB_NAME) || true
	createdb -h $(DB_HOST) -p $(DB_PORT) -U $(DB_USER) $(DB_NAME)
	$(MAKE) build

analytics:
	@echo "Running analytics queries..."
	$(PSQL) -f analytics/customer_analysis.sql
