-- sample_data.sql
USE sql_workflow;

-- Populate customers
INSERT INTO customers (name, email, phone, created_at, status) VALUES
('Asha Patel', 'asha.patel@example.com', '9123456780', '2024-07-01 10:00:00','active'),
('Rohit Singh', 'rohitsingh@example', '9123456781', '2024-07-05 11:15:00','active'), -- invalid email
('Kiran Rao', NULL, '9123456782', '2024-07-07 09:20:00','inactive'),
('Meera Joshi', 'meera.joshi@example.com', '9123456783', '2024-08-01 14:05:00','active'),
('Vikram Das', 'vikram.das@example.com', '9123456784', '2024-09-10 16:30:00','active');

-- Duplicate and more rows
INSERT INTO customers (name, email, phone) VALUES
('Sam Wilson','sam.w@example.com','9123456790'),
('Test User','testuser@domain','9123456791'),
('Null Email', NULL, '9123456792');

-- Populate accounts (map customers -> accounts)
INSERT INTO accounts (customer_id, account_type, balance, created_at) VALUES
(1,'savings', 120000.00, '2024-07-02'),
(2,'current', 500.00, '2024-07-06'),
(3,'savings', 0.00, '2024-07-08'),
(4,'current', 78000.50, '2024-08-02'),
(5,'savings', 150000.00, '2024-09-11'),
(6,'savings', 50.00, '2024-10-01'),
(7,'current', 0.00, '2024-11-01'),
(8,'savings', NULL, '2024-11-05'); -- null balance to simulate bad data

-- Populate transactions (some invalid to test cleanup)
INSERT INTO transactions (account_id, amount, transaction_type, created_at, remarks) VALUES
(1, 5000.00,'credit','2024-10-01 10:00:00','salary'),
(1, 1200.00,'debit','2024-10-02 12:00:00','shopping'),
(2, -500.00,'debit','2024-10-05 09:00:00','negative-test'), -- invalid negative (to show detection)
(3, 0.00,'credit','2024-10-06 09:30:00','zero-amount'), -- invalid zero
(4, 20000.00,'credit','2024-10-07 18:00:00','bonus'),
(5, 150.00,'debit','2024-10-08 11:00:00','atm'),
(8, NULL, NULL,'2024-10-09 11:00:00','incomplete'); -- invalid row

-- Add many transactions to simulate load
DELIMITER //
CREATE PROCEDURE populate_more_txn()
BEGIN
  DECLARE i INT DEFAULT 0;
  WHILE i < 30 DO
    INSERT INTO transactions (account_id, amount, transaction_type, created_at, remarks)
    VALUES (1, FLOOR( RAND()*5000 ) + 10, 'debit', NOW() - INTERVAL FLOOR(RAND()*30) DAY, 'auto-gen');
    SET i = i + 1;
  END WHILE;
END;
//
DELIMITER ;
CALL populate_more_txn();
DROP PROCEDURE IF EXISTS populate_more_txn;
