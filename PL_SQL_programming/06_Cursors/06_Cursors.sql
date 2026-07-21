SET SERVEROUTPUT ON;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance INT,
    LastModified DATE,
    IsVIP CHAR(1)
);

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountType VARCHAR2(20),
    Balance INT,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionDate DATE,
    Amount INT,
    TransactionType VARCHAR2(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanAmount INT,
    InterestRate INT,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary INT,
    Department VARCHAR2(50),
    DepartmentID INT,
    HireDate DATE
);

CREATE TABLE ErrorLogs (
    ErrorID INT PRIMARY KEY,
    ErrorMessage VARCHAR2(255),
    ErrorDate DATE
);



-- Customers
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (1, 'Rahul Sharma', TO_DATE('1985-04-15', 'YYYY-MM-DD'), 100000, TO_DATE('2026-01-15', 'YYYY-MM-DD'));

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (2, 'Priya Verma', TO_DATE('1992-08-20', 'YYYY-MM-DD'), 150000, TO_DATE('2026-01-15', 'YYYY-MM-DD'));

-- Accounts
INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (1, 1, 'Savings', 100000, TO_DATE('2026-01-15', 'YYYY-MM-DD'));

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (2, 2, 'Checking', 150000, TO_DATE('2026-01-15', 'YYYY-MM-DD'));

-- Transactions
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (1, 1, TO_DATE('2026-02-10', 'YYYY-MM-DD'), 20000, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2, 2, TO_DATE('2026-02-12', 'YYYY-MM-DD'), 30000, 'Withdrawal');

-- Loans
INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (1, 1, 500000, 7.5, TO_DATE('2026-01-01', 'YYYY-MM-DD'), ADD_MONTHS(TO_DATE('2026-01-01', 'YYYY-MM-DD'), 60));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (2, 2, 1000000, 8.0, TO_DATE('2026-03-01', 'YYYY-MM-DD'), ADD_MONTHS(TO_DATE('2026-03-01', 'YYYY-MM-DD'), 36));

-- Employees
INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (1, 'Amit Kumar', 'Manager', 900000, 'HR', TO_DATE('2020-06-15', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (2, 'Sneha Patel', 'Developer', 800000, 'IT', TO_DATE('2022-03-20', 'YYYY-MM-DD'));





CREATE OR REPLACE PROCEDURE GenerateMonthlyStatements AS
    CURSOR monthly_cursor IS
        SELECT a.CustomerID, t.TransactionDate, t.Amount
        FROM Transactions t
        JOIN Accounts a ON t.AccountID = a.AccountID
        WHERE EXTRACT(MONTH FROM t.TransactionDate) = EXTRACT(MONTH FROM SYSDATE)
          AND EXTRACT(YEAR FROM t.TransactionDate) = EXTRACT(YEAR FROM SYSDATE);

    v_customer_id INT;
    v_transaction_date DATE;
    v_amount DECIMAL(10, 2);
BEGIN
    FOR record IN monthly_cursor LOOP
        v_customer_id := record.CustomerID;
        v_transaction_date := record.TransactionDate;
        v_amount := record.Amount;

        DBMS_OUTPUT.PUT_LINE('CustomerID: ' || v_customer_id || 
                             ', Date: ' || v_transaction_date || 
                             ', Amount: ' || v_amount);
    END LOOP;
END;
/



CREATE OR REPLACE PROCEDURE ApplyAnnualFee AS
    CURSOR account_cursor IS
        SELECT AccountID, Balance
        FROM Accounts;

    v_account_id INT;
    v_balance DECIMAL(10, 2);
    annual_fee DECIMAL(10, 2) := 50.00; 
BEGIN
    FOR record IN account_cursor LOOP
        v_account_id := record.AccountID;
        v_balance := record.Balance;

        UPDATE Accounts
        SET Balance = v_balance - annual_fee
        WHERE AccountID = v_account_id;

        DBMS_OUTPUT.PUT_LINE('AccountID: ' || v_account_id || ' - Annual fee applied.');
    END LOOP;
END;
/






CREATE OR REPLACE PROCEDURE UpdateLoanInterestRates AS
    CURSOR loan_cursor IS
        SELECT LoanID, InterestRate
        FROM Loans;

    v_loan_id INT;
    v_current_rate DECIMAL(5, 2);
    v_new_rate DECIMAL(5, 2);
BEGIN
    FOR record IN loan_cursor LOOP
        v_loan_id := record.LoanID;
        v_current_rate := record.InterestRate;

        v_new_rate := v_current_rate * 1.05;

        UPDATE Loans
        SET InterestRate = v_new_rate
        WHERE LoanID = v_loan_id;

        DBMS_OUTPUT.PUT_LINE('LoanID: ' || v_loan_id || ' - Updated interest rate to: ' || v_new_rate);
    END LOOP;
END;
/







BEGIN
    GenerateMonthlyStatements;
END;
/

BEGIN
    ApplyAnnualFee;
END;
/

BEGIN
    UpdateLoanInterestRates;
END;
/