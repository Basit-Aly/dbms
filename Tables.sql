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