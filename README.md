# Banking Operations Management System

## Overview

The **Banking Operations Management System** is designed to manage daily operational tasks in an efficient and automated way. The system will handle customer accounts, transactions, loans, and other essential banking operations. By centralizing and automating these processes, the system ensures data accuracy, enhances operational efficiency, and improves the overall customer experience.

### Key Features:
- **Customer Account Management:** Create, update, and manage customer accounts seamlessly.
- **Transaction Handling:** Process deposits, withdrawals, and transfers efficiently.
- **Loan Management:** Track and manage loan applications, approvals, and repayments.
- **Automated Operations:** Reduce manual intervention and improve efficiency through automation.

### Business Needs / Problems Addressed:
1. **Data Management:** Centralized and organized storage of customer and transaction data.
2. **Data Integrity / Accuracy:** Ensures accurate and consistent data across all operations.
3. **Operational Efficiency:** Automates repetitive tasks, reducing errors and saving time.
4. **Customer Experience:** Provides a smooth and reliable banking experience for customers.

## Entities and Business Rules

The system is built around the following **entities** and their associated **business rules**:

### Entities:
1. **Customer**
2. **Employee**
3. **Account Type**
4. **Account**
5. **Branch**
6. **Transaction**
7. **Loan**
8. **Loan Repayment**
9. **Card**

### Business Rules:
1. **Customer and Account:**
   - A customer can have multiple accounts.
   - Each account belongs to only one customer.

2. **Customer and Loan:**
   - A customer can take zero or one loan.
   - Each loan is associated with only one customer.

3. **Account and Account Type:**
   - An account can only be of one account type.
   - Each account type can have multiple accounts.

4. **Account and Transaction:**
   - An account can perform multiple transactions.
   - Each transaction is associated with only one account.

5. **Loan and Loan Repayment:**
   - A loan has multiple payment schedules.
   - Each payment schedule belongs to only one loan.

6. **Account and Card:**
   - An account has only one card.
   - Every card is tied to only one account.

## Deployment

To deploy and run the **Banking Operations Management System**, follow these steps:

1. **Upload the Database:**
   - Locate the `project.sql` file in the project repository.
   - This file contains the database schema and initial data required for the system.

2. **Using LiveSQL:**
   - Go to [Oracle LiveSQL](https://livesql.oracle.com/).
   - Copy the contents of the `project.sql` file and paste them into the LiveSQL script editor.

3. **Using SQL Developer:**
   - Open the `project.sql` file in SQL Developeron your local machine. Connect to your Oracle database using your credentials
   - This will create the necessary tables, relationships, and insert initial data.
   - Run some querries for testing.

