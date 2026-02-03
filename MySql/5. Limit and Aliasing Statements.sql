SELECT * 
from employee_demographics;

-- Limit & Aliasing

SELECT * 
from employee_demographics
LIMIT 5; -- Only give the top 5 values of the table


SELECT * 
from employee_demographics
ORDER BY age DESC -- If we want last 5 people having age ooldest then we will use the order by age with desc
LIMIT 5;

SELECT * 
from employee_demographics
ORDER BY age DESC
LIMIT 2,1; -- basically here according to the order by we get aur filters item in desending order 
-- now limit 2,1 does that it start from the 2 second row and checks the next 1 row and give that as output - 2 vali row ke order by se jo aayi hogi usi next 1 vali output dega
-- limit 2,2 mtlb 2nd row ke baad ki next 2 rows as a result dega

-- ALIASING 
SELECT gender, AVG(age) 
from employee_demographics
GROUP BY  gender;

SELECT gender, AVG(age) AS avg_age -- avg_age is the alias we are using in having clause -> even without AS we can use like -> AVG(age) avg_age
from employee_demographics
GROUP BY  gender
HAVING avg_age > 40; -- rather using the AVG(age) as whole to avoid confusion we can create different col name as alias
-- gender	avg_age(The alias)
-- Male 	41.2857