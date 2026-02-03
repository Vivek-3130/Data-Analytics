/*UNIONS ->
The UNION operator is used to combine the result-set of two or more SELECT statements.
The UNION operator automatically removes duplicate rows from the result set.
*/

SELECT *
from employee_demographics;

SELECT * 
from employee_salary;

SELECT age , gender , birth_date from employee_demographics -- both should have 3-3 colname then only it would excecute
UNION
SELECT first_name, last_name , occupation from employee_salary
ORDER BY age; 

SELECT first_name, last_name from employee_demographics -- both should have 3-3 colname then only it would excecute
UNION -- Here when in both table there is same column name and same values also then UNION DISTINCT is used, by default union is distinct
-- But is we want all the rows even if having similar data we will use UNION ALL
SELECT first_name, last_name from employee_salary;

-- CORE EXAMPLE--

SELECT 
    first_name, last_name, gender, 'Middle Aged Male' AS LABEL
FROM
    employee_demographics
WHERE
    age > 40 AND gender = 'male' 
UNION SELECT 
    first_name, last_name, gender, 'Middle Aged Female' AS LABEL
FROM
    employee_demographics
WHERE
    age > 40 AND gender = 'female' 
UNION SELECT 
    first_name,
    last_name,
    occupation,
    'Highly Paid Employee' AS LABEL
FROM
    employee_salary
WHERE
    salary > 70000
ORDER BY
	first_name, last_name;  -- 	Chris	Traeger	 Male	        Middle Aged Male
	                        --  Chris	Traeger	 City Manager	Highly Paid Employee
    

/*
first_name	last_name	gender	        LABEL
Jerry	    Gergich	    Male	        Middle Aged Male
Chris	    Traeger	    Male	        Middle Aged Male
------------------------------------------------------------
Leslie	    Knope	    Female	        Middle Aged Female
Donna	    Meagle	    Female	        Middle Aged Female
------------------------------------------------------------
Leslie	    Knope	    Deputy Director Highly Paid Employee
Chris	   Traeger	    City Manager	Highly Paid Employee
*/ 


