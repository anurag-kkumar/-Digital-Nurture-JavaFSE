-- TRIGGER 2

CREATE OR REPLACE TRIGGER LogTransaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog
    VALUES(
        AuditLog_Seq.NEXTVAL,
        :NEW.TransactionID,
        :NEW.TransactionDate,
        :NEW.AccountID,
        :NEW.Amount,
        :NEW.TransactionType
    );
END;
/

SHOW ERRORS TRIGGER LogTransaction;