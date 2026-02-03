SELECT *
from parks_and_recreation.employee_demographics;

#This symbol is used for commenting 

SELECT first_name,
last_name,
gender,
age,
#In Sql the mathematic operation is used in this order :- PEMDAS - parenthesis,exponents,multiply,division,addition,subtraction
(age + 10 ) * 10 + 10 - 5
from parks_and_recreation.employee_demographics;

SELECT DISTINCT first_name
#Every name is diffrent thats why nothing will happen here and every value will come in output
from parks_and_recreation.employee_demographics;

SELECT DISTINCT gender
#Here the gender have only 2 choices male and female using distinct will give only male and female in output
from parks_and_recreation.employee_demographics;

SELECT DISTINCT first_name, gender
#Here the gender and first name bpth will come as the fisrt name is distint in all case
from parks_and_recreation.employee_demographics;