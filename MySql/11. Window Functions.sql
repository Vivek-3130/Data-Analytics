-- WINDOW Functions

SELECT gender AS Gender , AVG(salary) AS Avg_Salary  -- if we are using the aggregated functions then we have to use the group by query every time
FROM employee_demographics dem 
JOIN employee_salary sal
ON  dem.employee_id = sal.employee_id -- gender wise avg de dega salary ka
GROUP BY gender; -- gender from the first table and the average of salary from other thats why used joins

-- Here we will be using OVER() function to get the avg of each gender specifically

SELECT dem.first_name, dem.last_name, sal.occupation, gender , AVG(salary) OVER(PARTITION BY gender)
-- 	Donna	Meagle	 Office Manager	 Female	53750.0000
-- 	Chris	Traeger	 City Manager    Male	57428.5714
FROM employee_demographics dem 
JOIN employee_salary sal
ON  dem.employee_id = sal.employee_id;

-- We are using window fucntion over group by as we can also get extra colnmae like first and last name
-- without using a group by and also ig we use the group by simple the avg slary will be similar to their salry and not that what we want the seperated one

-- 	Female	56090.9091 with just OVER() --  Female	53750.0000 with OVER(PARTITION BY gender)
-- 	Male	56090.9091                  -- 	Female	53750.0000
-- 	Female	56090.9091                  -- 	Male	57428.5714
-- so on till the last person gender    -- 	Male	57428.5714

-- Here we used the OVER() means over all avgs, sirf ye krenge mix mathch rows aayegi
-- Now we will be seperating the gender with partition ki ladkiyo ka sirf avg aur ldko ka sirf
-- 4 ladkiya hai baki lde -> OVER(PARTITION BY gender) 

SELECT dem.first_name, dem.last_name, sal.occupation, gender , SUM(salary) OVER(PARTITION BY gender)
-- 	Donna	Meagle	 Office Manager	 Female	215000
-- 	Chris	Traeger	 City Manager    Male	402000
FROM employee_demographics dem
JOIN employee_salary sal
ON  dem.employee_id = sal.employee_id;

-- ROLLING Function

SELECT dem.employee_id ,dem.first_name, dem.last_name, sal.occupation, gender , salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_Total
-- It give the total of specific gender total and the end of females all salary, like Cumulative frequency
-- then all the males their salary and at the end gives the salary total(On the last person)
FROM employee_demographics dem
JOIN employee_salary sal
ON  dem.employee_id = sal.employee_id;

-- ROWNUMBER Function
SELECT dem.employee_id ,dem.first_name, dem.last_name, sal.occupation, gender , salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS Row_numbers, -- return OVER() rownumber 1,2,3,4,5,6,7,8,9,10,11
-- OVER(PARTITION BY gender ORDER BY salary DESC) -> female 1,2,3,4 then males 1,2,3,4,5,6,7 by salary(desc)
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS Rank_numbers, -- give rank to ordering by genders & salary
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS Dense_Rank_numbers
/*                                                         Row  Rank
11	Mark	Brendanawicz	City Planner	Male	57000	4	4
3	Tom	    Haverford	    Entrepreneur	Male	50000	5	5
5	Jerry	Gergich	        Office Manager	Male	50000	6	5 -> Dense_Rank me 7th ki jgha 6 ho jayega
10	Andy	Dwyer	        Shoe Shiner 	Male	20000	7	7 -> Giving Rank Positionally
*/
FROM employee_demographics dem
JOIN employee_salary sal
ON  dem.employee_id = sal.employee_id;