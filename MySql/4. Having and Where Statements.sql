SELECT * 
from employee_demographics;

# HAVING v/s WHERE Clasue

SELECT gender , AVG(age)
from employee_demographics
GROUP BY gender 
HAVING AVG(age) > 40; -- only male will get printed as the avg is 41 and for females it is 38 -> 
-- gender	AVG(age)
-- Male	    41.2857
-- HAVING function bna hi hai aggregated function se chize filter krne ke liye
-- WHERE isiliye group by ke sath use nhi krenge as vo pehle hi filter kr leta hai aggregated function se and baad me uspr group by nhi lg pata hai

SELECT * 
from employee_salary; -- office manager in occupation pr try krenge as vo 2 baar hai


-- Here we will will be using where with having to use the aggregated function with the where clause
SELECT occupation , AVG(salary)
-- 	Office Manager	55000.0000 -- Without where clause ye tha output aur iske sath baki sab ka bhi average
from employee_salary
WHERE occupation LIKE '%Manager%' -- Here it first filter the occupation row having manager in their occupation then did the average 
-- occupation	    AVG(salary)
-- Office Manager	55000.0000
-- City Manager	    90000.0000
GROUP BY occupation -- Ye krna zruri tha tbhi having use ho pata for aggr func
HAVING AVG(salary) > 70000; -- Where me filter hui row,fir group by hua dono, ab  having me check hua and filter hui row ke andr aggr func ki kisme avg more than 70000 hai
-- 	occupation	 AVG(salary)
--  City Manager 90000.0000
;

/*
In SQL, the WHERE clause is evaluated before the GROUP BY clause, which is why you cannot use aggregate functions like COUNT(), AVG(), SUM(), or MAX() in the WHERE clause.
The WHERE clause filters individual rows based on conditions applied to each row before any aggregation occurs. Since aggregate functions operate on groups of rows, they cannot be used in the WHERE clause because the grouping has not yet taken place.
Attempting to use an aggregate function in the WHERE clause results in an error such as "Invalid use of group function" in MySQL or similar errors in other SQL databases.

The correct approach is to use the HAVING clause after GROUP BY to filter groups based on aggregate results.
The HAVING clause is specifically designed for filtering aggregated data, meaning it evaluates conditions after the grouping and aggregation have been performed.
For example, if you want to find cities with an average temperature above 16°C, you must group by city first and then use HAVING AVG(temperature) > 16 to filter the grouped results*/