-- optimization.sql (fixed for MySQL)

USE sql_workflow;

-- 1. Create indexes only if they don't already exist
SET @idx_exists := (
    SELECT COUNT(*)
    FROM information_schema.statistics
    WHERE table_schema = 'sql_workflow'
      AND table_name = 'accounts'
      AND index_name = 'idx_accounts_customer_id'
);

SET @stmt := IF(@idx_exists = 0,
    'CREATE INDEX idx_accounts_customer_id ON accounts(customer_id);',
    'SELECT "Index idx_accounts_customer_id already exists";'
);
PREPARE stmt1 FROM @stmt;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;


-- Index for transactions.account_id
SET @idx_exists2 := (
    SELECT COUNT(*)
    FROM information_schema.statistics
    WHERE table_schema = 'sql_workflow'
      AND table_name = 'transactions'
      AND index_name = 'idx_txn_account_id'
);

SET @stmt2 := IF(@idx_exists2 = 0,
    'CREATE INDEX idx_txn_account_id ON transactions(account_id);',
    'SELECT "Index idx_txn_account_id already exists";'
);
PREPARE stmt2 FROM @stmt2;
EXECUTE stmt2;
DEALLOCATE PREPARE stmt2;


-- Index for transactions.created_at
SET @idx_exists3 := (
    SELECT COUNT(*)
    FROM information_schema.statistics
    WHERE table_schema = 'sql_workflow'
      AND table_name = 'transactions'
      AND index_name = 'idx_txn_created_at'
);

SET @stmt3 := IF(@idx_exists3 = 0,
    'CREATE INDEX idx_txn_created_at ON transactions(created_at);',
    'SELECT "Index idx_txn_created_at already exists";'
);
PREPARE stmt3 FROM @stmt3;
EXECUTE stmt3;
DEALLOCATE PREPARE stmt3;

-- Continue to optimized vs slow queries after this...
