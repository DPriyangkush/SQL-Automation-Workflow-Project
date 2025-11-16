-- error_handling.sql
USE sql_workflow;

-- Example: attempt to add invalid transaction: negative amount (should signal error)
-- Run interactively:
-- CALL add_transaction(1, -200, 'credit', 'test-negative');

-- Example: valid insert
-- CALL add_transaction(1, 200, 'credit', 'test-credit');

-- Example: use a wrapper to capture SIGNAL error messages (client will show error).
-- MySQL does not support TRY/CATCH like SQL Server; SIGNAL raises an error and client receives it.
-- You can simulate handling by checking inputs before calling procedures from application code (Python/Node).
