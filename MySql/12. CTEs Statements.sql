-- CTEs -> Common Table Expressions
-- CTEs is used immediately after calling it with the WITH function

WITH CTE_Examples AS -- here CTEs is represent AS the queries we have given in side the bracket
( -- its our own table data we created as ctes - like subques=ries
SELECT 
    gender, AVG(salary) AVG_salary, MAX(salary) Max_salary, MIN(salary) Min_salary, COUNT(salary) Count_salary
FROM
    employee_demographics dem
        JOIN
    employee_salary sal ON dem.employee_id = sal.employee_id
GROUP BY gender
)
-- SELECT * from CTE_Examples -- immediately using the ctes we created , we are extrating the data from cte we created as a table 
SELECT AVG(Avg_salary) , MAX(Max_salary)from CTE_Examples -- We Can do major calculations as well easily
;

-- SELECT AVG(Avg_salary) , MAX(Max_salary)from CTE_Examples;-- Nothing will happen as CTE_Example doesn't exists,that's why we have to use immedeately before closing colons
-- Here we are not saving the CTE table and thats why we arent able to exceute it, next me save krenge aur use bhi


-- Subqueries same way, but readability is bad
-- --------------------------------------------------------------------------------------------------------------
SELECT AVG(Avg_salary) -- basically of make and female both ise m=possible hoga as avg hume ander se mil rha hai
FROM -- CTE me hum upr create krke niche call krte hai yha sb upr krna pdta hai
(SELECT 
    gender, AVG(salary) AVG_salary, MAX(salary) Max_salary, MIN(salary) Min_salary, COUNT(salary) Count_salary
FROM
    employee_demographics dem
        JOIN
    employee_salary sal ON dem.employee_id = sal.employee_id
GROUP BY gender) AS Salary_data; -- we have to give a name(alias) to derived table we have created
-- --------------------------------------------------------------------------------------------------------------

-- Creating Multiple CTEs Inside One

WITH CTE_Examples AS
(
SELECT employee_id, gender , birth_date
FROM employee_demographics
WHERE birth_date > '1985-01-01'
)
,
CTE_Examples2 AS 
(
SELECT employee_id ,CONCAT(first_name ," ",last_name) AS Full_name, salary
FROM employee_salary
WHERE salary >= 50000
)
-- Now we will join both the CTEs
SELECT * FROM CTE_Examples CT1 -- Sb kuch dono tables se aajega hum pr CT2.Full_name CT1.birth_date bhi sirf call kr skte hai
JOIN CTE_Examples2 CT2
ON CT1.employee_id = CT2.employee_id -- kuch to common chahiye for the joins
;
/*                     e_id    Full_name        salary
3	Male	1987-03-04	3	Tom Haverford	    50000
7	Female	1988-12-01	7	Ann Perkins 	    55000
9	Male	1985-07-26	9	Ben Wyatt	        70000
12	Male	1986-07-27	12	Craig Middlebrooks	65000
*/












