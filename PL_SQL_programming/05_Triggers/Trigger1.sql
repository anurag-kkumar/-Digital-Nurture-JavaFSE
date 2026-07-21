
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
    TransactionType VARCHAR2(20),
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

CREATE TABLE AuditLog (
    AuditID INT PRIMARY KEY,
    TransactionID INT,
    TransactionDate DATE,
    AccountID INT,
    Amount INT,
    TransactionType VARCHAR2(20)
);




CREATE SEQUENCE AuditLog_Seq
START WITH 1
INCREMENT BY 1
NOCACHE;



INSERT INTO Customers
VALUES (1,'Rahul Sharma',
TO_DATE('1985-08-15','YYYY-MM-DD'),
50000,SYSDATE,'N');

INSERT INTO Customers
VALUES (2,'Priya Verma',
TO_DATE('1993-02-10','YYYY-MM-DD'),
75000,SYSDATE,'Y');



INSERT INTO Accounts
VALUES (1,1,'Savings',50000,SYSDATE);

INSERT INTO Accounts
VALUES (2,2,'Current',75000,SYSDATE);



INSERT INTO Transactions
VALUES (1,1,SYSDATE,10000,'DEPOSIT');

INSERT INTO Transactions
VALUES (2,2,SYSDATE,5000,'WITHDRAWAL');


INSERT INTO Loans
VALUES (1,1,500000,8,
SYSDATE,
ADD_MONTHS(SYSDATE,60));

INSERT INTO Loans
VALUES (2,2,300000,9,
SYSDATE,
ADD_MONTHS(SYSDATE,36));



INSERT INTO Employees
VALUES (1,
'Amit Singh',
'Branch Manager',
900000,
'HR',
101,
TO_DATE('2022-04-15','YYYY-MM-DD'));

INSERT INTO Employees
VALUES (2,
'Neha Gupta',
'Software Engineer',
750000,
'IT',
102,
TO_DATE('2023-08-20','YYYY-MM-DD'));


-- TRIGGER 1


CREATE OR REPLACE TRIGGER UpdateCustomerLastModified
BEFORE UPDATE ON Customers
FOR EACH ROW
BEGIN
    :NEW.LastModified := SYSDATE;
END;
/

SHOW ERRORS TRIGGER UpdateCustomerLastModified;
