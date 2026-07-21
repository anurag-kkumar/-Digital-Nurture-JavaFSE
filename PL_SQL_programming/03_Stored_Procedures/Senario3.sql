
-- Scenario 3 : Transfer Funds
 
CREATE OR REPLACE PROCEDURE TransferFunds
(
    p_from INT,
    p_to INT,
    p_amount NUMBER
)
IS
    v_balance NUMBER;
BEGIN

    SAVEPOINT start_trans;

    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE AccountID=p_from;

    IF v_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20001,'Insufficient Funds');
    END IF;

    UPDATE Accounts
    SET Balance=Balance-p_amount
    WHERE AccountID=p_from;

    UPDATE Accounts
    SET Balance=Balance+p_amount
    WHERE AccountID=p_to;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Transfer Successful');

EXCEPTION

WHEN OTHERS THEN

    ROLLBACK TO start_trans;

    INSERT INTO ErrorLogs
    VALUES
    (
        ErrorLogs_SEQ.NEXTVAL,
        SQLERRM,
        SYSDATE
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE(SQLERRM);

END;
/
CREATE SEQUENCE ErrorLogs_SEQ
START WITH 1
INCREMENT BY 1;

BEGIN
    TransferFunds(1,2,100);
END;
/
SELECT * FROM Accounts;