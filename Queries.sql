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




