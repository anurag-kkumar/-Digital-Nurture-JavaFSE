CREATE OR REPLACE FUNCTION CalculateAge (
    dob IN DATE
)
RETURN NUMBER
IS
    age NUMBER;
BEGIN
    age := FLOOR(MONTHS_BETWEEN(SYSDATE, dob) / 12);
    RETURN age;
END;
/
     DECLARE
    v_age NUMBER;
BEGIN
    v_age := CalculateAge(TO_DATE('23-01-2004','DD-MM-YYYY'));
    DBMS_OUTPUT.PUT_LINE('Age = ' || v_age);
END;
/