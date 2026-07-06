CREATE TABLE accounts (
    account_id   NUMBER PRIMARY KEY,
    balance      NUMBER(10,2) NOT NULL
);
INSERT INTO accounts VALUES (101, 1000);
INSERT INTO accounts VALUES (102, 300);
CREATE OR REPLACE FUNCTION HasSufficientBalance (
    p_account_id IN NUMBER,
    p_amount     IN NUMBER
) 

RETURN NUMBER
IS
    v_balance NUMBER;
BEGIN
    SELECT balance
    INTO v_balance
    FROM accounts
    WHERE account_id = p_account_id;

    IF v_balance >= p_amount THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/
SET SERVEROUTPUT ON;

DECLARE
    v_result NUMBER;
BEGIN
    v_result := HasSufficientBalance(101, 500);

    IF v_result = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Sufficient Balance');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Insufficient Balance');
    END IF;
END;
/