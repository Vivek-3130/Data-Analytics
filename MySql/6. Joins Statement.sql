-- JOINS in SQL 
SELECT *
from employee_demographics;

SELECT * 
from employee_salary;

-- INNER JOINS

SELECT *
from employee_demographics
INNER JOIN employee_salary
-- 2 Ron Swanson Director of Parks and Recreation 70000 1 -- this will be left out as it is not common in both the tables
ON employee_demographics.employee_id = employee_salary.employee_id -- we need to specify the table and common colnam
; -- by default its a inner join if we just use join

# From now we will be using Alias ,so as not to waste tym in writing whole table name

SELECT *
from employee_demographics as dem
INNER JOIN employee_salary as sal
ON dem.employee_id = sal.employee_id
;

SELECT dem.employee_id , dem.first_name , sal.last_name, age , occupation -- here we need to specify the the table alas if there exist any same colname
from employee_demographics as dem
INNER JOIN employee_salary as sal
ON dem.employee_id = sal.employee_id
;

-- OUTER JOINS

SELECT dem.employee_id, sal.employee_id, dem.age, sal.occupation
from employee_demographics as dem
RIGHT JOIN employee_salary as sal -- isne left wale me jo common tha vo return kiya + right table sal ke sare de diye with 2 Ron , as well
ON dem.employee_id = sal.employee_id; -- employee salary ki sari entries aayengi + jo dem me common hogi vo dem vali table se aayegi
-- demID  salID demAge  salOccupation
-- 1	  1	     44	    Deputy Director of Parks and Recreation
-- NULL   2		 NULL   Director of Parks and Recreation
-- Not Common    Not Common

SELECT dem.employee_id, sal.employee_id, dem.age, sal.occupation
from employee_demographics as dem
LEFT JOIN employee_salary as sal -- isne right wale me jitne thae vo return kiya + left table me salary me jo common tha vo return kiya
ON dem.employee_id = sal.employee_id;

-- SELF JOINS

SELECT *
from employee_salary emp1
JOIN employee_salary emp2
ON emp1.employee_id +1 = emp2.employee_id; -- here we are assinging the empID(more by 1) to the self table , paring them in a match

/* 
Emp1+1                  EqualsTo                                        Emp2
|1 Leslie Knope	    Deputy Director of Parks and Recreation	75000	1 |	2 Ron	Swanson	  Director of Parks and Recreation  70000	1 |
|2 Ron	 Swanson	Director of Parks and Recreation    	70000	1 |	3 Tom	Haverford Entrepreneur	                    50000	1 |
|3 Tom	 Haverford	Entrepreneur	                        50000	1 |	4 April	Ludgate	  Assistant to the Director of Park	25000	1 |
*/

SELECT
emp1.employee_id as Pehla_banda, emp1.first_name as baby, emp1.last_name as last,
emp2.employee_id as Dusra_bandi, emp2.first_name as jaan, emp2.last_name as last
from employee_salary emp1
JOIN employee_salary emp2
ON emp1.employee_id +10 = emp2.employee_id;

/* emp1.employee_id +10 = emp2.employee_id (Just pairing them for a dance)
  baby	 last	     	jaan	last
1 Leslie Knope	 | 11	Mark	Brendanawicz
2 Ron	 Swanson | 12	Craig	Middlebrooks
*/

/* emp1.employee_id +1 = emp2.employee_id
|1 Leslie Knope	  | 2	Ron	  Swanson   |
|2 Ron	 Swanson  |	3	Tom	  Haverford |
|3 Tom	 Haverford|	4	April Ludgate   |
*/

-- JOINING MULTIPLE TABLES TOGETHER

SELECT 
sal.dept_id as salaryID, sal.occupation ,
pd.department_id as parkID, pd.department_name
from employee_demographics as dem
INNER JOIN employee_salary as sal
 ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments as pd
 ON sal.dept_id = pd.department_id -- here we can not equal to empID from dem as it is already in sal
 
 -- colname diff its ok as pd.department_id has different values
 -- output-> department_id me 1,4,3,6 hoga as dept_id me 1,4,3,6 he common hai ans department_id ke 2 and 5 eft out reh jayenge
 -- RIGHT JOIN me sare department_id vale 1,2,3,4,5,6 vale sare aate pr dept_id ke bs 1,4,3,6 as vhi common hai
 -- LEFT JOIN me RIGHT JOIN ka ulta hota
 -- LEFT JOIN parks_departments as pd
 -- RIGHT JOIN parks_departments as pd
;

SELECT *
from parks_departments;