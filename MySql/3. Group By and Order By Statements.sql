SELECT *
from employee_demographics;

# GROUP BY Statements

SELECT gender
from employee_demographics
GROUP BY gender; -- here it will give male and female in input as there onlw two choices

SELECT gender , AVG(age) -- here we are usig the aggregated function and also getting the output as the avg age of female and male 
from employee_demographics
GROUP BY gender;

SELECT gender , AVG(age) , MAX(age) , MIN(age) , COUNT(age)-- it will give the max age in female and male / also min will give the minimum ages of both the genders
-- count will give the number of females and male in the table
from employee_demographics
GROUP BY gender;

-- Another table data
SELECT * 
from employee_salary;

SELECT occupation , salary  -- but jb sath me salary ke sath group by krenge tb 2 baar office manager aayega as salaries different hai
from employee_salary
GROUP BY occupation , salary; -- sare occupation show up hojayenge ,sirf occupation use krenge ek hi baar office manager aayega


# ORDER BY Statements - Use for getting the data in ascending or descending order

SELECT *
from employee_demographics
ORDER BY age; -- Normally occurs in ascending order -1,2,3,4,5

SELECT *
from employee_demographics
ORDER BY first_name; -- Normally occurs in ascending order a,b,c,d,e ORDER BY first_name ASC -> for ascending order

SELECT *
from employee_demographics
ORDER BY first_name DESC; -- for descending z,y,x,w,v

SELECT first_name , gender , age
from employee_demographics
ORDER BY gender , age DESC; -- pehle female sare then male sare ,alphabetically and age in desending order female 46,44,35,29 the male ki 61,43,40...

# Rather using the column name everytime we can use the column numbers numerically

SELECT *
from employee_demographics
ORDER BY 5, 4
; -- here the 5th is the gender and 4th is the age , gender and age will be sorted
