# SQL-Driven Data Workflow & Automation System

A complete end-to-end SQL automation project featuring stored procedures, views, CTE-based reports, indexing optimization, error handling, and automated data quality checks.

This project was designed to simulate a real enterprise SQL environment—similar to workflows used in banking, fintech, risk management, and data engineering teams (e.g., HSBC, JPMC, Barclays, Citi).

---

## 🚀 Project Features

### 🔹 1. Database Schema
- `customers`  
- `accounts`  
- `transactions`  
- `dq_log` (Data Quality Log Table)

### 🔹 2. Stored Procedures
- `add_transaction()` — Validations + business logic + error handling  
- `data_quality_check()` — Automated DQ scan + logging  

### 🔹 3. Views
- `v_customer_overview` — customer → accounts → transaction summary  
- `v_high_value_accounts` — accounts with high monthly volume  

### 🔹 4. CTE Reports
- Monthly transaction summary  
- Last 30-day heavy activity  

### 🔹 5. Error Handling
- TRY/CATCH  
- SIGNAL for validation  
- Logging failed quality checks  

### 🔹 6. Query Optimization
- Before vs After EXPLAIN plans  
- Indexing strategies  
- Refactored nested queries  

### 🔹 7. Automation
- MySQL Event Scheduler  
- Daily DQ job inserted into `dq_log`

---

## 🏗️ Project Structure

```
SQL-Data-Workflow-Automation/
│── schema.sql
│── sample_data.sql
│── views.sql
│── stored_procedures.sql
│── ctes.sql
│── automation_scripts.sql
│── optimization.sql
│── error_handling.sql
│── run_all.sh
│── assets/
│   └── screenshots/
```

---

## 🐳 Run the Project Using Docker

### 1. Start MySQL Container
```bash
docker run --name mysql-wf -e MYSQL_ROOT_PASSWORD=pass123 -p 3306:3306 -d mysql:8.0
```

### 2. Copy Project Files to Container
```bash
docker cp . mysql-wf:/sql/
```

### 3. Enter Container
```bash
docker exec -it mysql-wf bash
```

### 4. Run All SQL Scripts
```bash
cd /sql
chmod +x run_all.sh
./run_all.sh
```

---

## 📸 Screenshots (Proof of Working System)

### 1. MySQL Workbench Connection
![MySQL Workbench connection to Docker MySQL (127.0.0.1, port 3306)](assets/Connection-Screen.png)

### 2. SHOW DATABASES
![Output showing sql_workflow database](assets/Show-Databases-screen.png)

### 3. Schema Expanded
![Tables, Views, Stored Procedures visible under schema](assets/Schema%20Screen.png.png)

### 4. SHOW TABLES
![Screenshot showing: customers, accounts, transactions, dq_log](assets/Show%20Tables%20Screen.png)

### 5. Table Previews

#### Customers
![SELECT * FROM customers LIMIT 5;](assets/Preview%20first%20rows%20from%20customers.png)

#### Accounts
![SELECT * FROM accounts LIMIT 5;](assets/Preview%20accounts%20screen.png)

#### Transactions
![SELECT * FROM transactions LIMIT 5;](assets/Preview%20transactions%20screen.png)

### 6. View Outputs

#### v_customer_overview
![View output showing customer overview](assets/customer%20overview%20screen.png)

#### v_high_value_accounts
![View output showing high value accounts](assets/high%20value%20accounts%20screen.png)

### 7. CTE Reports

#### Monthly Summary
![CTE result showing account_id, total_credit, total_debit, txn_count](assets/monthly%20transaction%20summary.png)

#### Last 30 Days
![Heavy-activity CTE result](assets/last%2030%20days%20heavy%20transaction%20summary.png)

### 8. Stored Procedure Execution

#### Valid Transaction
![CALL add_transaction(1, 500, 'credit', 'workbench-test')](assets/transaction%20addition.png)

#### Invalid Transaction (error handling)
![ERROR 45000 – Invalid amount](assets/invalid%20amount%20transaction.png)

### 9. Data Quality Automation

#### Running DQ Check
![CALL data_quality_check() output](assets/data%20quality%20check.png)

### 10. Query Optimization

#### Before Indexing (slow query)
![EXPLAIN plan — high row count, no index used](assets/slow%20query.png)

#### After Indexing
![EXPLAIN plan — using index, lower rows](assets/optimised%20query.png)

#### SHOW INDEX
![Index list output](assets/show%20indexes%20from%20accounts.png)
![Index list output](assets/show%20indexes%20from%20transactions.png)

### 11. Automation (Event Scheduler)
![SHOW EVENTS FROM sql_workflow;](assets/check%20automated%20logs.png)

### 12. ER Diagram (Workbench Reverse Engineering)
![ERD showing: customers → accounts → transactions](assets/er-diagram.png)

---

## 📘 Skills Demonstrated

✅ SQL (T-SQL-like patterns adapted for MySQL)  
✅ Stored Procedures  
✅ Views & CTEs  
✅ Data Quality Framework  
✅ Performance Optimization  
✅ Automation (Event Scheduler)  
✅ Containerized SQL Development (Docker)  
✅ Enterprise-style data modeling  

### Perfect for roles such as:
- SQL Developer
- Data Engineer
- Consultant Specialist (HSBC)
- BI Developer
- ETL Developer
- Database Engineer

---

## ✨ Author

**Priyangkush Debnath**  
SQL • Data Engineering • Backend Development • Automation
