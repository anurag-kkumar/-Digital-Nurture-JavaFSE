Create table EMPLOYEE (
    EmpID Number Primary key,
    Salary Decimal(10,2),
    department VARCHAR(20)
);
INSERT INTO EMPLOYEE (EmpID, Salary, Department)
VALUES (101, 45000.00, 'HR');

INSERT INTO EMPLOYEE (EmpID, Salary, Department)
VALUES (102, 55000.50, 'IT');

INSERT INTO EMPLOYEE (EmpID, Salary, Department)
VALUES (103, 60000.00, 'Finance');

INSERT INTO EMPLOYEE (EmpID, Salary, Department)
VALUES (104, 48000.75, 'Marketing');

INSERT INTO EMPLOYEE (EmpID, Salary, Department)
VALUES (105, 70000.25, 'Sales');

CREATE TABLE ErrorLog (
    LogID NUMBER GENERATED ALWAYS AS IDENTITY,
    ErrorMessage VARCHAR2(200),
    LogDate DATE
);



Create or replace PROCEDURE salaryIncre 
(ID in Number ,percentInc in NUMBER)
is
error varchar2(200);
begin
    

        Update EMPLOYEE set Salary=Salary+((percentInc*Salary)/100) where EmpID=ID;
       
        
        if SQL%ROWCOUNT =0
        THEN
         RAISE NO_DATA_FOUND;
        else
         DBMS_OUTPUT.PUT_LINE('salary updated of id :'||ID);
        end if;
        COMMIT;
    
EXCEPTION 
WHEN NO_DATA_FOUND THEN
     
       INSERT INTO ErrorLog(ErrorMessage, LogDate)
    VALUES ('Invalid Employee ID', SYSDATE);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Invalid Employee ID');

WHEN OTHERS THEN
    erroR := SQLERRM;
    ROLLBACK;

        INSERT INTO ErrorLog(ErrorMessage, LogDate)
        VALUES (error, SYSDATE);

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Salary update failed.');
END;
/
BEGIN
    salaryIncre(103,10);
    end;
    /
    BEGIN
    salaryIncre(110,10);
    end;
    /
    select *from ERRORLOG;
    