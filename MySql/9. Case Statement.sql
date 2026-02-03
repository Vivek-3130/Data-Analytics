-- CASE Statement

SELECT 
    first_name AS FIRST_NAME,
    last_name AS LAST_NAME,
    age AS AGE,
    CASE -- from here we can use out case statement
        WHEN age <= 30 THEN 'Young' -- if this ,then this
        WHEN age BETWEEN 31 AND 45 THEN 'Middle Aged'
        WHEN age > 45 THEN 'Senior Aged'
    END AS AGE_CATEGORY -- end of the first when loop like in any other language
from
    employee_demographics;

-- Pay Increase and Bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% bonus

SELECT 
    first_name AS FIRST_NAME,
    last_name AS LAST_NAME,
    salary AS SALARY,
    CASE
        WHEN salary < 50000 THEN salary + (salary * 5) / 100
        WHEN salary >= 50000 THEN salary + (salary * 7) / 100
    END AS SALARY_INCREMENT,
    CASE
        WHEN dept_id = 6 THEN salary + (salary * 10) / 100
        ELSE 'No Bonus'
    END AS BONUS_TO_FINANCE_DEPT
FROM
    employee_salary;
