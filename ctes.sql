-- ctes.sql
USE sql_workflow;

-- Monthly transaction summary per account (current month)
-- MySQL 8+ supports WITH (CTE)
WITH monthly_txn AS (
    SELECT
        account_id,
        SUM(CASE WHEN transaction_type='credit' THEN amount ELSE 0 END) AS total_credit,
        SUM(CASE WHEN transaction_type='debit' THEN amount ELSE 0 END) AS total_debit,
        COUNT(*) AS txn_count
    FROM transactions
    WHERE YEAR(created_at) = YEAR(CURRENT_DATE())
      AND MONTH(created_at) = MONTH(CURRENT_DATE())
    GROUP BY account_id
)
SELECT * FROM monthly_txn ORDER BY total_debit DESC;

-- Top 5 accounts by total activity last 30 days
WITH last_30 AS (
    SELECT account_id, SUM(IFNULL(amount,0)) AS total_amt, COUNT(*) AS cnt
    FROM transactions
    WHERE created_at >= NOW() - INTERVAL 30 DAY
    GROUP BY account_id
)
SELECT * FROM last_30 ORDER BY total_amt DESC LIMIT 5;
