include .env
export

GREEN=\033[0;32m
RED=\033[0;31m
NC=\033[0m

PSQL=psql -q -v ON_ERROR_STOP=1 \
	-P pager=off \
	-P border=2 \
	-P linestyle=unicode \
	-P format=aligned \
	-P null='-' \
	-h $(DB_HOST) -p $(DB_PORT) -U $(DB_USER) -d $(DB_NAME)

build:
	@echo "Creating database schema..."
	@$(PSQL) -f database/create_db_schema.sql > build.log 2>&1 \
	&& echo "$(GREEN)Build complete.$(NC)" \
	|| (echo "$(RED)Build failed. Check build.log for details.$(NC)"; exit 1)

reset:
	@echo "Dropping and recreating database..."
	dropdb -h $(DB_HOST) -p $(DB_PORT) -U $(DB_USER) $(DB_NAME) || true
	createdb -h $(DB_HOST) -p $(DB_PORT) -U $(DB_USER) $(DB_NAME)
	$(MAKE) build

analysis:
	@echo "Running analytics queries..."
	@$(PSQL) -f analytics/01_base_views.sql
	@$(PSQL) -f analytics/02_customer_analytics.sql
