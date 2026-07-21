
BEGIN

    DBMS_OUTPUT.PUT_LINE('Scenario 1 : Customer updates profile');

    UPDATE Customers
    SET Name='Rahul Sharma Updated'
    WHERE CustomerID=1;

    DBMS_OUTPUT.PUT_LINE('Scenario 2 : Deposit Rs.20,000');

    INSERT INTO Transactions
    VALUES(3,1,SYSDATE,20000,'DEPOSIT');

    DBMS_OUTPUT.PUT_LINE('Scenario 3 : Withdraw Rs.5,000');

    INSERT INTO Transactions
    VALUES(4,1,SYSDATE,5000,'WITHDRAWAL');

    --------------------------------------------------------
    -- Scenario 4
    -- Invalid withdrawal
    --------------------------------------------------------

    BEGIN

        INSERT INTO Transactions
        VALUES(5,1,SYSDATE,1000000,'WITHDRAWAL');

    EXCEPTION
        WHEN OTHERS THEN

        DBMS_OUTPUT.PUT_LINE('Withdrawal Failed');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);

    END;

    --------------------------------------------------------
    -- Scenario 5
    -- Invalid Deposit
    --------------------------------------------------------

    BEGIN

        INSERT INTO Transactions
        VALUES(6,1,SYSDATE,-1000,'DEPOSIT');

    EXCEPTION
        WHEN OTHERS THEN

        DBMS_OUTPUT.PUT_LINE('Deposit Failed');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);

    END;

END;
/