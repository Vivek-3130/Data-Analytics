-- SUBQUERIES IN SQL

SELECT *
from employee_demographics dem
WHERE employee_id IN ( SELECT employee_id from employee_salary WHERE dept_id = 1); -- here it matches the employee_i of one class to other where the dept_id in another class in 1

SELECT first_name , salary , -- sirf AVG(salary) krte to same salary logo ki as an average lgti
(SELECT AVG(salary) from employee_salary) -- Leslie	75000	57250.0000(Average salary of the all the salaries in the table)
from employee_salary
GROUP BY first_name,salary;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
from employee_demographics
GROUP BY gender; -- yha pr smalest age + largest age ka avg nhi ho payega ab next query dekh subqueries ke through hoga

SELECT 
    AVG(avg_age),
    AVG(max_age),
    AVG(min_age),
    AVG(count_age)
FROM
    (SELECT 
        gender, AVG(age) as avg_age, MAX(age) as max_age, MIN(age) as min_age, COUNT(age) as count_age
    FROM
        employee_demographics
    GROUP BY gender) AS Age_aggregated
;