-- CREATING A PROCEDURE TO INCREASE A DEPARTMENTS BUDGET
CREATE OR REPLACE PROCEDURE INCREASE_BUDGET(DEPT IN NUMBER, VAL IN NUMBER)
IS
BEGIN
    UPDATE DEPARTMENT
    SET MONTHLY_BUDGET = MONTHLY_BUDGET + VAL
    WHERE DEPT_ID = DEPT;
    
    /**
    UPDATE DEPARTMENT
    SET MONTHLY_BUDGET = 
        ((SELECT MONTHLY_BUDGET
        FROM DEPARTMENT
        WHERE DEPT_ID = DEPT) + VAL)
    WHERE DEPT_ID = DEPT;
    **/

END;
/

BEGIN
    INCREASE_BUDGET(1,6000);
    INCREASE_BUDGET(2,13000);
    INCREASE_BUDGET(3,11000);
    INCREASE_BUDGET(4,1300);
    INCREASE_BUDGET(5,8000);
    INCREASE_BUDGET(6,10000);
    COMMIT;
END;

-- SHOW BUDGET USED SIDE BY SIDE WITH DEPARTMENT BUDGET
SELECT D.DEPT_NAME DEPARTMENT, D.MONTHLY_BUDGET BUDGET, SUM(E.MONTHLY_SALARY) "BUDGET USED"
FROM EMPLOYEE E
-- FULL OUTER -- THIS WILL SHOW US HR WHICH IS NOT SHOWN BECAUSE IT DOESNT HAVE ANY EMPLOYEES
JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID
GROUP BY D.DEPT_NAME, D.MONTHLY_BUDGET;


-- SET UP A STORED PROCEDURE WHICH CHECKS IF THERE IS ENOUGH BUDGET FOR A RAISE
-- IF THE BUDGET ALLOWS, THE RAISE OCCURS
-- IF THE BUDGET DOES NOT, THE RAISE DOES NOT

-- DELCARE OUR PROCEDURE
CREATE OR REPLACE PROCEDURE GIVE_RAISE(INPUT_ID EMPLOYEE.EMP_ID%TYPE, RAISE_AMOUNT EMPLOYEE.MONTHLY_SALARY%TYPE)
IS
-- VARIABLE DECLARATIONS FOR COMPARISON
DEPT_BUDGET DEPARTMENT.MONTHLY_BUDGET%TYPE;
BUDGET_USED DEPARTMENT.MONTHLY_BUDGET%TYPE;
-- CREATING PLACEHOLDERS FOR EMPLOYEE INFORMATION
EMPLOYEE_NAME EMPLOYEE.EMP_NAME%TYPE;
CURRENT_SALARY EMPLOYEE.MONTHLY_SALARY%TYPE;

BEGIN
    -- SAVE THE DEPARTMENT BUDGET OF THE INPUT EMPLOYEE TO THE DEPT_BUDGET VARIABLE
    SELECT MONTHLY_BUDGET INTO DEPT_BUDGET
    FROM DEPARTMENT 
    WHERE DEPT_ID =
        (SELECT DEPT_ID
        FROM EMPLOYEE
        WHERE EMP_ID = INPUT_ID);
    --DBMS_OUTPUT.PUT_LINE(DEPT_BUDGET);
    
    -- GET THE AMOUNT OF BUDGET ALREADY USED
    SELECT SUM(MONTHLY_SALARY) INTO BUDGET_USED
    FROM EMPLOYEE
    WHERE DEPT_ID = 
        (SELECT DEPT_ID
        FROM EMPLOYEE
        WHERE EMP_ID = INPUT_ID);
    --DBMS_OUTPUT.PUT_LINE(BUDGET_USED);
    
    SELECT EMP_NAME, MONTHLY_SALARY INTO EMPLOYEE_NAME, CURRENT_SALARY -- IMPLICIT CURSOR
    FROM EMPLOYEE
    WHERE EMP_ID = INPUT_ID;
    
    IF ((BUDGET_USED+RAISE_AMOUNT)>DEPT_BUDGET) THEN
        DBMS_OUTPUT.PUT_LINE('INSUFFICIENT DEPARTMENT FUNDS. MONTHLY SALARY FOR '||EMPLOYEE_NAME||' REMAINS '||CURRENT_SALARY);
    ELSE
        -- UPDATE EMPLOYEE SALARY
        UPDATE EMPLOYEE
        SET MONTHLY_SALARY = MONTHLY_SALARY+RAISE_AMOUNT
        WHERE EMP_ID = INPUT_ID;
        DBMS_OUTPUT.PUT_LINE('RAISE SUCCCESSFULLY INCREASED BY '||RAISE_AMOUNT||'. NEW MONTHLY SALARY FOR '||EMPLOYEE_NAME||' IS '||(CURRENT_SALARY+RAISE_AMOUNT) );
    END IF;
END;

SET SERVEROUTPUT ON;

BEGIN
    GIVE_RAISE(7,60);
END;
