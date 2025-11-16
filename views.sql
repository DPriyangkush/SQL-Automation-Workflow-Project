-- views.sql
USE sql_workflow;

DROP VIEW IF EXISTS v_customer_overview;
CREATE VIEW v_customer_overview AS
SELECT 
    c.customer_id,
    c.name,
    c.email,
    a.account_id,
    a.account_type,
    a.balance,
    a.status AS account_status
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id;

DROP VIEW IF EXISTS v_high_value_accounts;
CREATE VIEW v_high_value_accounts AS
SELECT 
    account_id, customer_id, balance
FROM accounts
WHERE balance IS NOT NULL AND balance > 50000;
