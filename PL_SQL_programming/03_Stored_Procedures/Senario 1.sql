-- Enable Output
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


INSERT INTO Customers VALUES
(1,'Amit Sharma',DATE '1988-05-15',1000,SYSDATE,NULL);

INSERT INTO Customers VALUES
(2,'Priya Verma',DATE '1994-07-20',1500,SYSDATE,NULL);

INSERT INTO Accounts VALUES
(1,1,'Savings',1000,SYSDATE);

INSERT INTO Accounts VALUES
(2,2,'Current',1500,SYSDATE);

INSERT INTO Employees VALUES
(1,'Rohit Mehta','Manager',70000,'Operations',1,DATE '2026-01-15');

INSERT INTO Employees VALUES
(2,'Neha Gupta','Developer',60000,'IT',2,DATE '2026-03-20');

COMMIT;



-- SENARIO 1 : Monthly Interest

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
IS
    v_rows NUMBER;
BEGIN
    UPDATE Accounts
    SET Balance = Balance * 1.01
    WHERE AccountType='Savings';

    v_rows := SQL%ROWCOUNT;

    DBMS_OUTPUT.PUT_LINE('Accounts Updated = '||v_rows);
END;
/
BEGIN
    ProcessMonthlyInterest;
END;
/
SELECT * FROM Accounts;

