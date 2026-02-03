-- WHERE CLAUSE
SELECT * 
from employee_salary
;

SELECT *
# We can use as COUNT(employee_id) to get the count as 8, as 8 people have salary more than 50000
from employee_salary
WHERE salary > 50000 
;

SELECT *
from employee_salary
WHERE salary >= 50000 
;

SELECT * 
from employee_salary
WHERE salary < 50000
;

SELECT * 
from employee_salary
WHERE salary <= 50000
;

SELECT * 
from employee_salary
WHERE first_name = "Chris"
;


SELECT * 
from employee_demographics
;

SELECT first_name,
last_name,
age
from employee_demographics
WHERE age >= 40
;

-- AND , OR , NOT are the logical operators
SELECT * 
from employee_demographics
# here both has to be true
WHERE gender != "male" AND age > 40
;

SELECT * 
from employee_demographics
# here either can be true if only OR is used
WHERE birth_date > '1985--01-01'
# here 1st OR will get excecute the NOT male will be used
# this will give result for both male and female
OR NOT gender = "male"
;

SELECT * 
from employee_demographics
WHERE (first_name = "Leslie" AND age = 44) OR age > 55
# here the concept of PEMDAS will be used and not only return leslie buth also the person having age > 55
# (first_name = "Leslie" AND age = 44) OR NOT age > 55 , then return people with age not more than 55
;

-- LIKE Clause
-- % and _

SELECT *
from employee_demographics
# letter % (% iske pehle ke letter se jo bhi start ho rha hai aa jayega) ,beginning me A hoga to vo return hoga 
WHERE first_name LIKE "A%"
;

SELECT *
from employee_demographics
# letter % (% beech me kahi bhi aa skta hai letter vo return honge%)
WHERE first_name LIKE "%R%"
;

SELECT *
from employee_demographics
# letter % (% iske baad ke letter se jo bhi start ho rha hai aa jayega), last me jha A hoga wo return hoga
WHERE first_name LIKE "%A"
;

SELECT *
from employee_demographics
# letter A ke baad sirf 2 aur character hoge wo return hoga - Ann
WHERE first_name LIKE "A__"
;

SELECT *
from employee_demographics
# letter A ke baad sirf 3 aur character hoge wo return hoga - Andy
WHERE first_name LIKE "A___"
;

SELECT *
from employee_demographics
# letter A ke baad sirf 2 aur character hoge  plus uske baad bhi agr hai to vo return honge - April,Ann,Andy
WHERE first_name LIKE "A__%"
;

SELECT *
from employee_demographics
WHERE birth_date LIKE "1989%" # jha pr 1989 hai vo value return ho jayegi
;