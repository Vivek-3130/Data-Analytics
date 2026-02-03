-- STRING FUNCTIONS

SELECT LENGTH('Responsible'); -- give the length of the string

SELECT first_name, LENGTH(first_name)
from employee_demographics
ORDER BY LENGTH(first_name) DESC;

SELECT UPPER('Dedication'); -- convert string to uppercase
SELECT LOWER('Durability'); -- convert string to lowercase

SELECT UPPER(first_name) , UPPER(last_name) , LOWER(first_name), LOWER(last_name)
from employee_demographics;

SELECT TRIM('         Perseverance         '); -- If we use the TRIM('          Perseverance         ') then we wont get the spaces
SELECT ('         Perseverance         ');-- if we do not then we will get the spaces ('          Perseverance         ')
SELECT LTRIM('          Perseverance         '); -- remove spaces from just left side
SELECT RTRIM('          Perseverance         '); -- remove spaces from just right side

SELECT LEFT('Success', 4); -- Output is 'Succ'
SELECT RIGHT('Success', 4);-- Output is 'cess' 
SELECT SUBSTRING('Success',3,2); -- Output is 'cc'

SELECT first_name, LEFT(last_name, 3) , RIGHT(last_name, 2) -- Basically give only first & last 3&2 character of lastname as a substring of last_name
,SUBSTRING(first_name,1,length(first_name)) -- Gives output as 1 to length of each name i.e whole first_name
,birth_date
,SUBSTRING(birth_date,6,2) as birth_month
from employee_demographics;

SELECT first_name, REPLACE(first_name, "A" , 'Z') -- April	Zpril
from employee_demographics;

SELECT LOCATE("u", 'Accountability');
-- |	LOCATE("u", 'Accountability')
-- |	5

SELECT first_name , LOCATE('e', first_name) -- 	Leslie	2, 	Jerry	2, 	Ben	2
from employee_demographics;

SELECT first_name, last_name,
CONCAT(first_name,' ',last_name) AS full_name
from employee_demographics;

