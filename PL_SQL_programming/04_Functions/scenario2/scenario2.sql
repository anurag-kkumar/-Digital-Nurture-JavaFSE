CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment (
    p_loan_amount      IN NUMBER,
    p_interest_rate    IN NUMBER,
    p_loan_years       IN NUMBER
) RETURN NUMBER
IS
    v_monthly_rate NUMBER;
    v_months       NUMBER;
    v_emi          NUMBER;
BEGIN
    v_monthly_rate := (p_interest_rate / 100) / 12;
    v_months := p_loan_years * 12;

    IF v_monthly_rate = 0 THEN
        RETURN p_loan_amount / v_months;
    END IF;

    v_emi := (p_loan_amount * v_monthly_rate *
             POWER(1 + v_monthly_rate, v_months)) /
             (POWER(1 + v_monthly_rate, v_months) - 1);

    RETURN ROUND(v_emi, 2);
END;
/
SELECT CalculateMonthlyInstallment(500000, 8, 5) AS Monthly_Installment
FROM dual;

DECLARE
    v_emi NUMBER;
BEGIN
    v_emi := CalculateMonthlyInstallment(500000, 8, 5);
    DBMS_OUTPUT.PUT_LINE('Monthly Installment: ' || v_emi);
END;
/