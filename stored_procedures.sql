-- stored_procedures.sql
USE sql_workflow;

-- Insert transaction with validation and balance update (basic)
DROP PROCEDURE IF EXISTS add_transaction;
DELIMITER $$
CREATE PROCEDURE add_transaction(
    IN p_account_id INT,
    IN p_amount DECIMAL(15,2),
    IN p_type VARCHAR(10),
    IN p_remarks VARCHAR(255)
)
BEGIN
    DECLARE v_balance DECIMAL(15,2);
    -- Basic validations
    IF p_amount IS NULL OR p_amount <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid amount';
    END IF;
    IF p_type NOT IN ('credit','debit') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid transaction type';
    END IF;

    START TRANSACTION;
    -- Insert transaction
    INSERT INTO transactions (account_id, amount, transaction_type, created_at, remarks)
    VALUES (p_account_id, p_amount, p_type, NOW(), p_remarks);

    -- Update account balance
    SELECT balance INTO v_balance FROM accounts WHERE account_id = p_account_id FOR UPDATE;
    IF p_type = 'credit' THEN
        SET v_balance = IFNULL(v_balance,0) + p_amount;
    ELSE
        SET v_balance = IFNULL(v_balance,0) - p_amount;
    END IF;
    UPDATE accounts SET balance = v_balance WHERE account_id = p_account_id;
    COMMIT;
END$$
DELIMITER ;

-- Cleanup invalid records
DROP PROCEDURE IF EXISTS cleanup_invalid_records;
DELIMITER $$
CREATE PROCEDURE cleanup_invalid_records()
BEGIN
    -- Transactions with NULL/zero/negative amounts or missing type
    DELETE FROM transactions
    WHERE amount IS NULL OR amount <= 0 OR transaction_type IS NULL;

    -- Accounts with null balances set to 0
    UPDATE accounts SET balance = 0 WHERE balance IS NULL;
END$$
DELIMITER ;

-- Data quality check procedure: returns problem rows count & logs into dq_log
DROP PROCEDURE IF EXISTS data_quality_check;
DELIMITER $$
CREATE PROCEDURE data_quality_check()
BEGIN
    DECLARE issue_count INT DEFAULT 0;
    -- count invalid emails
    SELECT COUNT(*) INTO @bad_emails FROM customers WHERE email IS NULL OR email NOT LIKE '%@%';
    SELECT COUNT(*) INTO @bad_balance FROM accounts WHERE balance < 0;
    SELECT COUNT(*) INTO @bad_txn FROM transactions WHERE amount IS NULL OR amount <= 0 OR transaction_type IS NULL;

    SET issue_count = IFNULL(@bad_emails,0) + IFNULL(@bad_balance,0) + IFNULL(@bad_txn,0);

    INSERT INTO dq_log (issue_count, notes)
    VALUES(issue_count, CONCAT('bad_emails=',IFNULL(@bad_emails,0),';bad_balance=',IFNULL(@bad_balance,0),';bad_txn=',IFNULL(@bad_txn,0)));

    -- Return summary for interactive use
    SELECT @bad_emails AS bad_emails, @bad_balance AS bad_balance, @bad_txn AS bad_txn, issue_count AS total_issues;
END$$
DELIMITER ;
