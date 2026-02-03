-- STORED Procedures -> A stored procedure is a precompiled set of SQL statements stored inside the database that can be executed repeatedly by calling its name.

SELECT *
FROM employee_salary
WHERE salary >= 50000;

CREATE PROCEDURE large_salaries() -- It will reflect inside the schemas created under large_salaries
SELECT *
FROM employee_salary
WHERE salary >= 50000;

CALL large_salaries(); -- here we are callingout our procedure we created
-- Calling in another file look like :- call parks_and_recreation.large_salaries();

DELIMITER $$ -- To run multiple queries we use delimiter adn stored procedures
CREATE PROCEDURE large_salaries3() -- It will reflect inside the schemas created under large_salaries
BEGIN 
    SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
-- Without delimiter these two querying are running individually 
	SELECT *
	FROM employee_salary
    WHERE salary >= 10000;
END $$  -- This is the end of large_salaries2() Procedure. ';' it is ignored. 
DELIMITER ;

CALL large_salaries3();

-- How to give parameters to a procedure , basically to use inside our code

DELIMITER $$ 
CREATE PROCEDURE large_salaries4(parameterID INT) -- the name of parameter and its data type we are passing
BEGIN 
    SELECT first_name,  last_name, salary
-- 	first_name	last_name	salary
-- 	Leslie	Knope	75000
	FROM employee_salary
    WHERE employee_id = parameterID; -- we are comparing it with the employeeID where it is one 
END $$  
DELIMITER ;

CALL large_salaries4(1);  -- here 1 is the integer parameter we have given























