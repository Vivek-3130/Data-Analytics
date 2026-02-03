-- Temporary Tabels ->Temporary tables in MySQL are special tables designed to store temporary result sets within a specific database session

CREATE TEMPORARY TABLE Temp_table
( -- serial_no INT PRIMARY KEY,
 first_name VARCHAR(58),
 last_name VARCHAR(58),
 favourite_movie VARCHAR(58)
);

SELECT * FROM Temp_table;

INSERT INTO Temp_table
VALUES('Utsav', 'Dodiya', 'Dr.Strangers'),
('Vaibhav','Patil','Stranger Things'),
('Vivek','Pandey','Games Of Thrones'),
('Ankit','Pandey','Dhurandar'),
('Satyam','Ghoshi','Ikkis');

SELECT * FROM Temp_table;

-- Let's see the other way

SELECT *
from employee_salary;

CREATE TEMPORARY TABLE SALARY_OVER_50K  -- it will create a temporary table of this name and it will be valid till the session is on
SELECT *
FROM employee_salary
WHERE salary > 50000;

SELECT * 
FROM SALARY_OVER_50K;
