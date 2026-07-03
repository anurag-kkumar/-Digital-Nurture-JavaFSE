--Scenario 1:  Handle exceptions during fund transfers between accounts.

Create table Account (
    accountID int PRIMARY KEY,
    accountNAME varchar(50) ,
    balance DECIMAL (10,2)
);
Insert into Account (accountID,accountNAME,balance) 
values (101,'Anurag',20000);

Insert into Account (accountID,accountNAME,balance) 
values (102,'deep',5000);

create table fundTransfers (
        tranferID int,
        senderAcc int,
        reciverAcc int,
        TransAmount int,
       TransStatus NUMBER(1)

);
CREATE TABLE ErrorLog (
    LogID NUMBER GENERATED ALWAYS AS IDENTITY,
    ErrorMessage VARCHAR2(200),
    LogDate DATE
);
INSERT INTO fundTransfers
VALUES (1,101,102,5000,1);

INSERT INTO fundTransfers
VALUES (2,102,101,6000,1);


CREATE OR REPLACE PROCEDURE SafeTransferFunds(
    p_sender     IN NUMBER,
    p_receiver   IN NUMBER,
    p_amount     IN NUMBER
)
IS
    v_balance Account.balance%TYPE;
     v_error   VARCHAR2(200);
BEGIN
    -- Get sender balance
    SELECT balance
    INTO v_balance
    FROM Account
    WHERE accountID = p_sender
    FOR UPDATE;

    -- Check balance
    IF v_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient Funds');
    END IF;

    -- Deduct amount from sender
    UPDATE Account
    SET balance = balance - p_amount
    WHERE accountID = p_sender;

    -- Add amount to receiver
    UPDATE Account
    SET balance = balance + p_amount
    WHERE accountID = p_receiver;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Funds transferred successfully.');

   EXCEPTION
    WHEN OTHERS THEN
        v_error := SQLERRM;

        ROLLBACK;

        INSERT INTO ErrorLog(ErrorMessage, LogDate)
        VALUES (v_error, SYSDATE);

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Transfer Failed.');
END;
/

-- case of sufficent balance
BEGIN
    SafeTransferFunds(101, 102, 5000);
END;
/
-- case of insufficent balance
BEGIN
    SafeTransferFunds(101, 102, 16000);
END;
/
SELECT * from ERRORLOG;