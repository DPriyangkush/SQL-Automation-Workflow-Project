-- automation_scripts.sql
USE sql_workflow;

-- Option A: MySQL Event Scheduler (runs daily at 02:00)
-- Ensure event scheduler is enabled: SET GLOBAL event_scheduler = ON;
DROP EVENT IF EXISTS daily_data_quality_event;
CREATE EVENT daily_data_quality_event
ON SCHEDULE EVERY 1 DAY
STARTS (CURRENT_DATE + INTERVAL 1 DAY) + INTERVAL '02:00' HOUR_MINUTE
DO
  CALL data_quality_check();

-- Option B: If your environment cannot use events, use a shell script + cron:
-- Example shell command to run daily:
-- mysql -u root -pYOURPASS -D sql_workflow -e "CALL data_quality_check();"
-- Add to crontab (run `crontab -e`):
-- 0 2 * * * /usr/bin/mysql -u root -p'YOURPASS' -D sql_workflow -e "CALL data_quality_check();"
