#!/usr/bin/env bash
# run_all.sh - run all SQL files in correct order (Linux/macOS)
DB="sql_workflow"
USER="root"
PASS="pass123"  # replace or prompt securely

mysql -u $USER -p$PASS < schema.sql
mysql -u $USER -p$PASS < sample_data.sql
mysql -u $USER -p$PASS < views.sql
mysql -u $USER -p$PASS < stored_procedures.sql
mysql -u $USER -p$PASS < ctes.sql
mysql -u $USER -p$PASS < optimization.sql
mysql -u $USER -p$PASS < automation_scripts.sql
mysql -u $USER -p$PASS < error_handling.sql

echo "All scripts executed. Check MySQL for the sql_workflow DB."
