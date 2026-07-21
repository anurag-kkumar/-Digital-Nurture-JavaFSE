-- Scenario 2 : Employee Bonus


CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus
(
    p_departmentID INT,
    p_bonus NUMBER
)
IS
BEGIN
    UPDATE Employees
    SET Salary = Salary + Salary*p_bonus/100
    WHERE DepartmentID = p_departmentID;

    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT||' Employee Updated');
END;
/
BEGIN
    UpdateEmployeeBonus(1,10);
END;
/

SELECT * FROM Employees;