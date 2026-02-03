-- TRIGGERS

SELECT * 
FROM employee_demographics;

SELECT *
FROM employee_salary;


DELIMITER $$
CREATE TRIGGER employee_insert -- Ye kb hoga after inserting in the employee_insert
       AFTER INSERT ON employee_salary
       FOR EACH ROW -- Applicable for each row jb tk new row insert hoti rahegi
       -- Humne jese hi yha nayi row insert ki vese hi event trigger hua
       -- After inserting the values it triggers the employee_demographics table
BEGIN
     INSERT INTO employee_demographics(employee_id, first_name, last_name)
     VALUES(NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;
-- In actual inside the tables and then inside the employee_salary , a Tigger will be shown in the schema
/* Trigger: employee_insert
   Definition:
   Event: INSERT 
   Timing: AFTER */

INSERT INTO employee_salary(employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13,'Jean-Ralpio','Saperstein','Exntertainment 720 CEO',1000000, NULL);
-- The moment we inserted the values in the employee_salary table , in the employee_demographics a new row added with these data 
-- 	13	Jean-Ralpio	Saperstein NULL NULL NULL -> As we only told new.employee_id,new.first_name, new.last_name


-- EVENTS
DELIMITER $$
CREATE EVENT personnels
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
     DELETE FROM employee_demographics
     WHERE age >= 60;
END $$
DELIMITER ;
-- Row having age as 61 will be deleted from the table the moment we will create our event

-- SHOW VARIABLES LIKE 'event%'; We can see wheather the event scheduler is on or off.
