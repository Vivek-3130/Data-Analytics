-- CASE STATEMENTS
-- When we want to add new column we can use this to segregate the data
SELECT 
    employee_id,
    first_name,
    last_name,
    salary,
    CASE
        WHEN salary > 65000 THEN 'High Salaried Person'
        WHEN salary > 50000 THEN 'Medium Salaried Person'
        WHEN salary > 35000 THEN 'Moderate Salaried Person'
        ELSE 'Low Salaried Person'
    END AS Category_Wise_Salary,
    CASE
        WHEN salary BETWEEN 45000 AND 65000 THEN 'Maruti Suzuki Baleno'
        WHEN salary BETWEEN 30000 AND 45000 THEN 'Maruti Suzuki Alto 800'
        WHEN salary BETWEEN 15000 AND 30000 THEN 'Tata Nano'
        WHEN salary BETWEEN 5000 AND 15000 THEN 'E-Rickshaw'
        ELSE 'Work Hard'
    END AS CAR_Wise_Employee
FROM
    employee_salary;