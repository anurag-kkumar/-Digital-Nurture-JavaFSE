CREATE OR REPLACE TRIGGER CheckTransactionRules
BEFORE INSERT ON Transactions
FOR EACH ROW

DECLARE
    currentBalance NUMBER;

BEGIN

    IF :NEW.TransactionType='WITHDRAWAL' THEN

        SELECT Balance
        INTO currentBalance
        FROM Accounts
        WHERE AccountID=:NEW.AccountID
        FOR UPDATE;

        IF :NEW.Amount>currentBalance THEN

            RAISE_APPLICATION_ERROR
            (-20001,
            'Insufficient balance.');

        END IF;

    END IF;

    IF :NEW.TransactionType='DEPOSIT' THEN

        IF :NEW.Amount<=0 THEN

            RAISE_APPLICATION_ERROR
            (-20002,
            'Deposit amount must be positive.');

        END IF;

    END IF;

END;
/

SHOW ERRORS TRIGGER CheckTransactionRules;