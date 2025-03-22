--Testing procedure CUSTOMERACCOUNT

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


--Testing Procedure perform_transaction
Begin
    perform_transaction('Withdrawal', 'ACC-PK-20241210022443', 2000);
    perform_transaction('Deposit', 'ACC-PK-20241210022447', 4000);
    perform_transaction('Transfer', 'ACC-PK-20241210022452', 2000, 'ACC-PK-20241210022450' );
End;

--Testing Procedue CreateLoan

Begin
    CreateLoan('CUST-1001', 480000,15, SYSDATE, 6); 
End;









