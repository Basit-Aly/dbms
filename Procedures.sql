-- Customer Table
CREATE TABLE Customer (
   Customer_ID VARCHAR2(255) PRIMARY KEY,
   First_Name VARCHAR2(50) NOT NULL,
   Last_Name VARCHAR2(50),
   Email VARCHAR2(100) UNIQUE,
   Phone_Number VARCHAR2(15) UNIQUE NOT NULL,
   Address VARCHAR2(255),
   Date_of_Birth DATE NOT NULL,
   Gender VARCHAR2(10),
   Registration_Date DATE DEFAULT SYSDATE
);

-- Employee Table
CREATE TABLE Employee (
   Employee_ID VARCHAR2(255) PRIMARY KEY,
   First_Name VARCHAR2(50) NOT NULL,
   Last_Name VARCHAR2(50),
   Job_Title VARCHAR2(50) NOT NULL,
   Hire_Date DATE,
   Salary NUMBER,
   Email VARCHAR2(255) UNIQUE,
   Contact_Number VARCHAR2(15)
);

-- Branch Table
CREATE TABLE Branch (
   Branch_ID VARCHAR2(255) PRIMARY KEY,
   Branch_Name VARCHAR2(255) NOT NULL,
   Branch_Location VARCHAR2(255) NOT NULL,
   Branch_Phone_Number VARCHAR2(15) UNIQUE NOT NULL,
   Manager_ID VARCHAR2(255) REFERENCES EMPLOYEE (Employee_ID)
);


-- Account Type Table
CREATE TABLE Account_Type (
   Type_Name VARCHAR2(255) PRIMARY KEY,    
   Interest_Rate NUMBER CHECK (Interest_Rate BETWEEN 0 AND 100),
   Minimum_Balance NUMBER
);

-- Account Table
CREATE TABLE Account (
   Account_Number VARCHAR2(255) PRIMARY KEY,
   Customer_ID VARCHAR2(255) REFERENCES Customer(Customer_ID),
   Type_Name VARCHAR2(255) REFERENCES Account_Type(Type_Name),
   Branch_ID VARCHAR2(255) REFERENCES Branch(Branch_ID),
   Balance NUMBER DEFAULT 0,
   Status VARCHAR2(20) DEFAULT 'Active',
   Opening_Date DATE DEFAULT SYSDATE,
   Closing_Date DATE,
   Last_Transaction_Date DATE
);

-- Transaction Table
CREATE TABLE Transaction (
   Transaction_ID NUMBER PRIMARY KEY,
   Account_Number VARCHAR2(255) REFERENCES Account(Account_Number),
   Transaction_Type VARCHAR2(20) CHECK (Transaction_Type IN ('Deposit', 'Withdrawal', 'Transfer')),
   Amount NUMBER CHECK (Amount > 0),
   Transaction_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Loan Table
CREATE TABLE Loan (
   Loan_ID NUMBER PRIMARY KEY,
   Customer_ID VARCHAR2(255) REFERENCES Customer(Customer_ID),
   Loan_Amount NUMBER CHECK (Loan_Amount > 0),
   Interest_Rate NUMBER CHECK (Interest_Rate BETWEEN 0 AND 100),
   Application_Date DATE,
   Approval_Date DATE,
   Repayment_Period NUMBER,
   Loan_Status VARCHAR2(20) DEFAULT 'Pending' CHECK (Loan_Status IN ('Approved', 'Rejected', 'Pending'))
);

-- Payment Schedule Table
CREATE TABLE Payment_Schedule (
   Repayment_ID NUMBER PRIMARY KEY, --installment id
   Loan_ID NUMBER REFERENCES Loan(Loan_ID),
   Princple_Amount NUMBER,
   Remaining_Amount NUMBER,
   Payment_Date DATE NOT NULL,
   Payment_Status VARCHAR2(20) CHECK (Payment_Status IN ('Paid', 'Pending', 'Overdue'))
);

-- Credit Card Table
CREATE TABLE Card (
   Card_ID VARCHAR2(255) PRIMARY KEY,
   Account_Number VARCHAR2(255) REFERENCES Account(Account_Number),
   Card_Type VARCHAR2(50),
   Issue_Date DATE,
   Expiry_Date DATE,
   CVV VARCHAR2(3)  -- credit card fraud prevention
);

--Create Data: Insert some data to your database to mimic a real-life database.

--Inserting data into Customer Table
--procedure automatically inserts data in customer table and creates an account 

--Inserting data in Employee Table
INSERT INTO Employee (Employee_ID, First_Name, Last_Name, Job_Title, Hire_Date, Salary, Email, Contact_Number)
VALUES ('EMP-101', 'Alex', 'White', 'Manager', SYSDATE, 80000, 'alex.white@example.com', '1112223334');

INSERT INTO Employee (Employee_ID, First_Name, Last_Name, Job_Title, Hire_Date, Salary, Email, Contact_Number)
VALUES ('EMP-102', 'Linda', 'Black', 'Cashier', SYSDATE - 365, 40000, 'linda.black@example.com', '2223334445');

INSERT INTO Employee (Employee_ID, First_Name, Last_Name, Job_Title, Hire_Date, Salary, Email, Contact_Number)
VALUES ('EMP-103', 'Chris', 'Green', 'Accountant', SYSDATE - 730, 60000, 'chris.green@example.com', '3334445556');

INSERT INTO Employee (Employee_ID, First_Name, Last_Name, Job_Title, Hire_Date, Salary, Email, Contact_Number)
VALUES ('EMP-104', 'Patricia', 'Gray', 'Clerk', SYSDATE - 100, 30000, 'patricia.gray@example.com', '4445556667');

INSERT INTO Employee (Employee_ID, First_Name, Last_Name, Job_Title, Hire_Date, Salary, Email, Contact_Number)
VALUES ('EMP-105', 'Edward', 'King', 'HR Manager', SYSDATE - 200, 75000, 'edward.king@example.com', '5556667778');

--Inserting data into Branch table
INSERT INTO Branch (Branch_ID, Branch_Name, Branch_Location, Branch_Phone_Number, Manager_ID)
VALUES ('BR-101', 'Main Branch', 'Downtown City', '9998887771', 'EMP-101');

INSERT INTO Branch (Branch_ID, Branch_Name, Branch_Location, Branch_Phone_Number, Manager_ID)
VALUES ('BR-102', 'East Branch', 'East City', '8887776662', 'EMP-102');

INSERT INTO Branch (Branch_ID, Branch_Name, Branch_Location, Branch_Phone_Number, Manager_ID)
VALUES ('BR-103', 'West Branch', 'West Side', '02145678901', 'EMP-103');


--Inserting data into Account_Type table
INSERT INTO Account_Type (Type_Name, Interest_Rate, Minimum_Balance)
VALUES ('Savings', 15, 1000);

INSERT INTO Account_Type (Type_Name, Interest_Rate, Minimum_Balance)
VALUES ('Current', 0.0, 1000);

INSERT INTO Account_Type (Type_Name, Interest_Rate, Minimum_Balance)
VALUES ('Fixed Deposit', 5.0, 5000);

--Inserting values in Account Table
--procedure will insert values in account table


--Inserting values in transaction table
--procedure will insert values in transaction table

--Inserting values in Loan table
--procedure will insert values in loan table

-- Inserting values in Payment_Schedule table
--procesure inserts value in this table

--Inserting values in Card table
--Procedure inserts value in this table

--Sequence and Trigger
-- Create a sequence for generating unique Customer IDs
CREATE SEQUENCE sequence_Customer_ID INCREMENT BY 1  START WITH 1000; --sequence starts with 1000 and increments by 1 for each new value

-- Create a trigger to automatically assign a Customer_ID when a new record is inserted into the Customer table
CREATE OR REPLACE TRIGGER Customer_BIR 
BEFORE INSERT ON Customer
FOR EACH ROW
BEGIN
    :NEW.Customer_ID := 'CUST-' || sequence_Customer_ID.NEXTVAL;
END;

--Procedures

-- Procedure to insert data into Customer, Account, and Card tables
CREATE OR REPLACE PROCEDURE Create_CustomerAccount (
    -- Inputs parameters for Customer details
    p_First_Name IN VARCHAR2,
    p_Last_Name IN VARCHAR2,
    p_Email IN VARCHAR2,
    p_Phone_Number IN VARCHAR2,
    p_Address IN VARCHAR2,
    p_Date_of_Birth IN DATE,
    p_Gender IN VARCHAR2,
    -- Inputs for Account details
    p_Type_Name IN VARCHAR2, -- Current, Savings, Fixed Deposit
    p_Initial_Deposit IN NUMBER,
    p_Card_Type IN VARCHAR2,   -- Credit, Debit
   --Input from Branch detials
    p_Branch_ID IN VARCHAR2    -- Branch ID 
) AS
    -- Variables for internal processing, -- Variables to store calculated and generated values
    v_Customer_ID VARCHAR2(255);
    v_Account_Number VARCHAR2(255);
    v_Card_ID VARCHAR2(255);
    v_CVV NUMBER;
BEGIN
    -- Insert customer details into Customer table
    INSERT INTO Customer (
        First_Name,
        Last_Name,
        Email,
        Phone_Number,
        Address,
        Date_of_Birth,
        Gender,
        Registration_Date
    ) VALUES (
        p_First_Name,
        p_Last_Name,
        p_Email,
        p_Phone_Number,
        p_Address,
        p_Date_of_Birth,
        p_Gender,
        SYSDATE
    )
    RETURNING Customer_ID INTO v_Customer_ID;

    -- Generate unique Account_Number
    v_Account_Number := 'ACC-PK-' || TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS');

    -- Insert account details into Account table, including Branch_ID
    INSERT INTO Account (
        Account_Number,
        Customer_ID,
        Type_Name,
        Branch_ID,
        Balance,
        Status,
        Opening_Date
    ) VALUES (
        v_Account_Number,
        v_Customer_ID,
        p_Type_Name,
        p_Branch_ID,
        p_Initial_Deposit,
        'Active',
        SYSDATE
    );

    -- Generate unique Card_ID
    v_Card_ID := 'CARD-PK-' || TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS');

    -- Generate random 3-digit CVV
    v_CVV := TRUNC(DBMS_RANDOM.VALUE(100, 999));

    -- Insert card details into Card table
    INSERT INTO Card (
        Card_ID,
        Account_Number,
        Card_Type,
        Issue_Date,
        Expiry_Date,
        CVV
    ) VALUES (
        v_Card_ID,
        v_Account_Number,
        p_Card_Type,
        SYSDATE,
        ADD_MONTHS(SYSDATE, 60), -- 5 years validity
        v_CVV
    );

    -- Output a success message
    DBMS_OUTPUT.PUT_LINE('Account created successfully.' );

    -- Commit transaction
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Rollback on failure
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;



--Testing procedure and creating an account
BEGIN
    CREATE_CUSTOMERACCOUNT('Saleem', 'Vazir', 'salim@gmail.com', '9234560', 'Karachi 123', TO_DATE('02-JUN-01', 'DD-MON-YY'), 'Male', 'Savings', 32000, 'Debit', 'BR-101');
    CREATE_CUSTOMERACCOUNT('Ali', 'Khan', 'ali.khan@example.com', '9234561', 'Islamabad 456', TO_DATE('15-MAR-95', 'DD-MON-YY'), 'Male', 'Current', 6000, 'Credit', 'BR-102');
    CREATE_CUSTOMERACCOUNT('Zara', 'Ahmed', 'zara.ahmed@example.com', '9234562', 'Lahore 789', TO_DATE('10-MAY-90', 'DD-MON-YY'), 'Female', 'Savings', 3000, 'Debit', 'BR-103');
    CREATE_CUSTOMERACCOUNT('Hina', 'Iqbal', 'hina.iqbal@example.com', '9234563', 'Rawalpindi 321', TO_DATE('05-AUG-88', 'DD-MON-YY'), 'Female', 'Savings', 12000, 'Credit', 'BR-101');
    CREATE_CUSTOMERACCOUNT('Usman', 'Farooq', 'usman.farooq@example.com', '9234564', 'Peshawar 654', TO_DATE('30-JAN-92', 'DD-MON-YY'), 'Male', 'Current', 6000, 'Debit', 'BR-102');
    CREATE_CUSTOMERACCOUNT('Sara', 'Shaikh', 'sara.shaikh@example.com', '9234565', 'Quetta 987', TO_DATE('22-JUL-87', 'DD-MON-YY'), 'Female', 'Savings', 15000, 'Credit', 'BR-103');
    CREATE_CUSTOMERACCOUNT('Bilal', 'Aslam', 'bilal.aslam@example.com', '9234566', 'Hyderabad 123', TO_DATE('19-SEP-89', 'DD-MON-YY'), 'Male', 'Current', 5000, 'Debit', 'BR-101');
    CREATE_CUSTOMERACCOUNT('Ayesha', 'Shah', 'ayesha.shah@example.com', '9234567', 'Multan 456', TO_DATE('12-NOV-93', 'DD-MON-YY'), 'Female', 'Savings', 10000, 'Credit', 'BR-102');
    CREATE_CUSTOMERACCOUNT('Faizan', 'Ali', 'faizan.ali@example.com', '9234568', 'Faisalabad 789', TO_DATE('08-APR-85', 'DD-MON-YY'), 'Male', 'Savings', 9000, 'Debit', 'BR-103');
    CREATE_CUSTOMERACCOUNT('Mehwish', 'Riaz', 'mehwish.riaz@example.com', '9234569', 'Sialkot 321', TO_DATE('18-DEC-86', 'DD-MON-YY'), 'Female', 'Current', 11000, 'Credit', 'BR-101');
END;

--Test

BEGIN
    CREATE_CUSTOMERACCOUNT('Hammad', 'Ali', 'hammad.ali@example.com', '9244556', 'Karachi 789', TO_DATE('20-APR-99', 'DD-MON-YY'), 'Male', 'Savings', 5000, 'Debit', 'BR-102');
END;

BEGIN
    CREATE_CUSTOMERACCOUNT('Sunil', 'Kumar', 'sunil.kumar@example.com', '9245789', 'Karachi 001', TO_DATE('20-JUL-98', 'DD-MON-YY'), 'Male', 'Current', 5000, 'Credit', 'BR-103');
END;

select * from customer;
select * from account;
select * from card;


--Sequence and trigger for transaction
CREATE SEQUENCE transaction_id_seq INCREMENT BY 1 START WITH 10000;

CREATE OR REPLACE TRIGGER transaction_BIR
BEFORE INSERT ON Transaction
FOR EACH ROW
BEGIN
    :NEW.Transaction_ID := transaction_id_seq.NEXTVAL;
END;


--Procedure for transaction
CREATE OR REPLACE PROCEDURE perform_transaction (
    p_transaction_type IN VARCHAR2, 
    p_account_number IN VARCHAR2, 
    p_amount IN NUMBER, 
    p_target_account IN VARCHAR2 DEFAULT NULL
) AS
    v_balance NUMBER;
    v_target_balance NUMBER;
    v_new_balance NUMBER;
    v_new_target_balance NUMBER;
BEGIN
    -- Start of transaction
    SAVEPOINT transaction_start;  -- If an error occurs later in the transaction, we can roll back to this specific point without undoing the entire transaction.

    -- Deposit: Add money to the account
    IF p_transaction_type = 'Deposit' THEN
        -- Retrieve current balance of the account
        SELECT balance INTO v_balance
        FROM Account
        WHERE account_number = p_account_number FOR UPDATE; --to lock the rows selected by a query, ensuring that no other transaction can modify or delete those rows until the current transaction is committed or rolled back
        
        -- Update balance
        v_new_balance := v_balance + p_amount;
        
        -- Update account with new balance
        UPDATE Account
        SET balance = v_new_balance,
            Last_Transaction_Date = SYSDATE
        WHERE account_number = p_account_number;
    
    -- Withdrawal: Subtract money from the account
    ELSIF p_transaction_type = 'Withdrawal' THEN
        -- Retrieve current balance of the account
        SELECT balance INTO v_balance
        FROM Account
        WHERE account_number = p_account_number FOR UPDATE;
        
        -- Check if there are enough funds for withdrawal
        IF v_balance < p_amount THEN
            RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds for withdrawal.');
        ELSE
            -- Update balance
            v_new_balance := v_balance - p_amount;
            
            -- Update account with new balance
            UPDATE Account
            SET balance = v_new_balance,
                Last_Transaction_Date = SYSDATE
            WHERE account_number = p_account_number;
        END IF;
    
    -- Transfer: Transfer money between two accounts
    ELSIF p_transaction_type = 'Transfer' THEN
        -- Validate target account exists
        IF p_target_account IS NULL THEN
            RAISE_APPLICATION_ERROR(-20003, 'Target account must be specified for transfer.');
        END IF;

        -- Retrieve balance for source account with lock
        SELECT balance INTO v_balance
        FROM Account
        WHERE account_number = p_account_number FOR UPDATE;
        
        -- Retrieve balance for target account with lock
        SELECT balance INTO v_target_balance
        FROM Account
        WHERE account_number = p_target_account FOR UPDATE;
        
        -- Check if the source account has enough balance
        IF v_balance < p_amount THEN
            RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds for transfer.');
        ELSE
            -- Deduct money from source account
            v_new_balance := v_balance - p_amount;
            UPDATE Account
            SET balance = v_new_balance,
                Last_Transaction_Date = SYSDATE
            WHERE account_number = p_account_number;
            
            -- Add money to target account
            v_new_target_balance := v_target_balance + p_amount;
            UPDATE Account
            SET balance = v_new_target_balance,
                Last_Transaction_Date = SYSDATE
            WHERE account_number = p_target_account;
        END IF;
    
    ELSE
        RAISE_APPLICATION_ERROR(-20002, 'Invalid transaction type.');
    END IF;
    
    -- Log the transaction into the Transaction table
    INSERT INTO Transaction (
        Account_Number, 
        Transaction_Type, 
        Amount, 
        Transaction_Date
    )
    VALUES (
        p_account_number, 
        p_transaction_type, 
        p_amount, 
        CURRENT_TIMESTAMP
    );
    
    -- Commit the transaction
    COMMIT;
    
    -- Print the result
    DBMS_OUTPUT.PUT_LINE('Transaction ' || p_transaction_type || ' completed successfully.');

EXCEPTION
    WHEN OTHERS THEN
        -- Rollback to the savepoint in case of any error
        ROLLBACK TO transaction_start;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


--Testing Procedure
Begin
    perform_transaction('Withdrawal', 'ACC-PK-20241210022443', 2000);
    perform_transaction('Deposit', 'ACC-PK-20241210022447', 4000);
    perform_transaction('Transfer', 'ACC-PK-20241210022452', 2000, 'ACC-PK-20241210022450' );
End;

select * from account;
select * from transaction;

--Procedure for Loan and repayment Schedule
CREATE OR REPLACE PROCEDURE CreateLoan (
    p_customer_id IN VARCHAR2,
    p_loan_amount IN NUMBER,
    p_interest_rate IN NUMBER,
    p_application_date IN DATE,
    p_repayment_period IN NUMBER
) IS
    v_loan_id NUMBER;
    v_monthly_installment NUMBER;
    v_interest_amount NUMBER;
    v_principal_per_installment NUMBER;
    v_remaining_amount NUMBER;
    v_payment_date DATE;
BEGIN
    -- Insert loan record
    SELECT NVL(MAX(Loan_ID), 0) + 1 INTO v_loan_id FROM Loan; -- Generate a unique Loan ID
    INSERT INTO Loan (
        Loan_ID, Customer_ID, Loan_Amount, Interest_Rate,
        Application_Date, Approval_Date, Repayment_Period, Loan_Status
    ) VALUES (
        v_loan_id, p_customer_id, p_loan_amount, p_interest_rate,
        p_application_date, SYSDATE, p_repayment_period, 'Pending'
    );

    -- Calculate interest amount and monthly installment
    v_interest_amount := (p_loan_amount * p_interest_rate) / 100;
    v_principal_per_installment := p_loan_amount / p_repayment_period;
    v_monthly_installment := v_principal_per_installment + (v_interest_amount / p_repayment_period);
    v_remaining_amount := p_loan_amount + v_interest_amount;
    
    -- Generate repayment schedule
    v_payment_date := ADD_MONTHS(p_application_date, 1); -- First payment after 1 month
    FOR i IN 1..p_repayment_period LOOP
        -- Update remaining amount
        v_remaining_amount := v_remaining_amount - v_monthly_installment;
        
        -- Insert repayment schedule
        INSERT INTO Payment_Schedule (
            Repayment_ID, Loan_ID, Princple_Amount, Remaining_Amount, 
            Payment_Date, Payment_Status
        ) VALUES (
            i + (v_loan_id * 1000), -- Unique repayment ID
            v_loan_id,
            v_principal_per_installment,
            v_remaining_amount,
            v_payment_date,
            'Pending'
        );
        
        -- Move to the next payment date
        v_payment_date := ADD_MONTHS(v_payment_date, 1); -- Next payment due in a month
    END LOOP;

    -- Commit the transaction
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Loan created successfully with Loan ID: ' || v_loan_id);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

Begin
    CreateLoan('CUST-1001', 480000,15, SYSDATE, 6); 
End;

select * from loan;
select * from payment_schedule;


--Update Procedures
--1. Updating Branch's Manager
CREATE OR REPLACE PROCEDURE update_branch (
    p_branch_id IN VARCHAR2,
    p_manager_id IN VARCHAR2
) AS
BEGIN
    UPDATE Branch 
    SET Manager_ID = p_manager_id
    WHERE Branch_ID = p_branch_id;
    
    COMMIT;
END;

--Testing the Procedure
Begin
    update_branch('BR-101', 'EMP-102');
End;


--2. Updating Employee's job_title and salary
CREATE OR REPLACE PROCEDURE update_employee (
    p_employee_id IN VARCHAR2,
    p_job_title IN VARCHAR2,
    p_salary IN NUMBER
) AS
BEGIN
    UPDATE Employee 
    SET Job_Title = p_job_title,
        Salary = p_salary
    WHERE Employee_ID = p_employee_id;
    
    COMMIT;
END;

--Testing the Procedure
Begin
    update_employee('EMP-101', 'Manager', 80000);
End;

--Delete Procedure
CREATE OR REPLACE PROCEDURE delete_row (
    p_table_name IN VARCHAR2,   
    p_column_name IN VARCHAR2,  
    p_value IN VARCHAR2          -- Value to match for deletion
) 
AS 
    v_sql VARCHAR2(1000);        -- Variable to store the dynamic SQL statement
BEGIN
    -- Construct the dynamic DELETE SQL statement
    -- Concatenates table name, column name, and uses a parameter placeholder
    v_sql := 'DELETE FROM ' || p_table_name || 
             ' WHERE ' || p_column_name || ' = :1';
    
    -- Execute the dynamically constructed SQL statement
    -- :1 is replaced with the actual value passed to the procedure
    EXECUTE IMMEDIATE v_sql USING p_value;
    
    COMMIT;
END;


BEGIN
    delete_row('Branch', 'Branch_ID', 'BR001');
END;


--Read Data: Write some SQL queries
--Query 1: Retrieve information of customer whose Gender is Male
SELECT * FROM Customer 
WHERE Gender = 'Male';

--Query 2: Retrieve details of customers whose accounts status is Active.
SELECT 
    c.Customer_ID, c.First_Name || ' ' || c.Last_Name AS Full_Name, c.Email, c.Phone_Number,a.Account_Number,a.Status AS Account_Status
FROM Customer c
JOIN Account a ON c.Customer_ID = a.Customer_ID
WHERE a.Status = 'Active';

--Query 3: Summarize the total account balance grouped by the account type.
SELECT at.Type_Name AS Account_Type, SUM(a.Balance) AS Total_Balance
FROM Account a
JOIN Account_Type at ON a.Type_Name = at.Type_Name
GROUP BY at.Type_Name;

--Query4: Retrieve a list of customers who have taken loans, along with their loan amount.
SELECT c.Customer_ID, c.First_Name || ' ' || c.Last_Name AS Full_Name, l.Loan_ID,l.Loan_Amount, l.Loan_Status
FROM Customer c
JOIN  Loan l ON c.Customer_ID = l.Customer_ID;

--Query5: List all credit cards issued, including the account holder’s details, card type, and expiry status.
SELECT c.Customer_ID, c.First_Name || ' ' || c.Last_Name AS Full_Name, cr.Card_ID, cr.Card_Type, cr.Issue_Date,cr.Expiry_Date,
CASE 
    WHEN cr.Expiry_Date < SYSDATE THEN 'Expired'
    ELSE 'Valid'
END AS Card_Status
FROM Card cr
JOIN Account a ON cr.Account_Number = a.Account_Number
JOIN Customer c ON a.Customer_ID = c.Customer_ID;




