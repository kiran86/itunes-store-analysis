include .env
export

GREEN=\033[0;32m
RED=\033[0;31m
NC=\033[0m

PSQL=PGPASSWORD=$(DB_PASSWORD) psql -q -v ON_ERROR_STOP=1 \
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
	@PGPASSWORD=$(DB_PASSWORD) dropdb -h $(DB_HOST) -p $(DB_PORT) -U $(DB_USER) $(DB_NAME) || true
	@PGPASSWORD=$(DB_PASSWORD) createdb -h $(DB_HOST) -p $(DB_PORT) -U $(DB_USER) $(DB_NAME)
	$(MAKE) build

analysis:
	@echo "Running analytics queries..."
	@$(PSQL) -f analytics/run_analytics.sql > analysis.log 2>&1 \
	&& echo "$(GREEN)Analytics complete. Check analysis.log for results.$(NC)" \
	|| (echo "$(RED)Analytics failed. Check analysis.log for details.$(NC)"; exit 1)

reports:
	@echo "Generating reports..."
	@$(PSQL) -f reports_md/run_analytics_md.sql > itunes_analysis_report.md
	@echo "$(GREEN)Report generated: itunes_analysis_report.md$(NC)"