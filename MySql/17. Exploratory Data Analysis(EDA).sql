-- Exploratory Data Analytics
SELECT *
FROM layoffs_staging2;

-- Here mostly we will be working with the total and percentage laid off
SELECT MAX(total_laid_off) -- It give output as 12000 no of emoployee got laid off in one day
,MAX(percentage_laid_off) -- It give 1 as the ouput 
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1 
ORDER BY total_laid_off DESC; -- Lets see which company laid off 100% employees

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company -- How many companies has laid off of how much employee Amazon  36000(Aggregated number)
ORDER BY 2 DESC; -- Column Wise Result

SELECT MIN(`date`),MAX(`date`) -- Date range between people got laid off
FROM layoffs_staging2; -- 1/10/2023	9/9/2022

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry -- From which industry does they lay off most : - 	Consumer	90364(Aggregated number)
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country -- From which country does they lay off most : - 		United States	513118(Aggregated number)
ORDER BY 2 DESC; 

SELECT YEAR(`date`) , SUM(total_laid_off) -- For in which year and most common we used 1 desc in order by :- 	2023	125677
FROM layoffs_staging2
GROUP BY YEAR(`date`) -- From which date does they lay off most : -	2023-01-04	16171(Aggregated number) -> SELECT `date`
ORDER BY 1 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage -- From which Stage does they lay off most :- Post-IPO	408264 (Aggregated number)
ORDER BY 2 DESC;

-- ___________THE REAL EDA___________ --

SELECT SUBSTR(`date`,1,7) AS `MONTH&YEAR` , SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTR(`date`,1,7) IS NOT NULL -- As null me bhi value aa rhi hti hume nhi chahiye thi vo
GROUP BY `MONTH&YEAR`
ORDER BY 1 ASC; -- In which month of which year there was a most lay off:- 	2022-07	  16223

-- Working with rollin total (Calculative something in a cumulative way like the no of lay of fro may to sept of particular year)
WITH Rolling_Total AS 
(
SELECT SUBSTR(`date`,1,7) AS `MONTH&YEAR` , SUM(total_laid_off) AS Sum_Of_Total_Off
FROM layoffs_staging2
WHERE SUBSTR(`date`,1,7) IS NOT NULL -- As null me bhi value aa rhi hti hume nhi chahiye thi vo
GROUP BY `MONTH&YEAR`
ORDER BY 1 ASC
) -- Yha tak data month per year wise aa chuka hai humare pass 	1/10/20	2391, in this way
SELECT `MONTH&YEAR`, Sum_Of_Total_Off, SUM(Sum_Of_Total_Off) OVER(ORDER BY `MONTH&YEAR`) AS Rolling_LayOffs -- Summing Over Month Wise
FROM Rolling_Total
GROUP BY `MONTH&YEAR`;
/*  Month&year Sum_Total  Rolling_Layoffs
	1/10/20	   2391	      2391
	1/11/20	   1646	      4037
	1/12/20	   1072	      5109   -- Kitne hr month se add on hote ja rhe hai
*/

-- -------> Now lets see which company laid off how many employees per year.
SELECT company , YEAR(`date`) ,SUM(total_laid_off)
FROM layoffs_staging2
WHERE YEAR(`date`) IS NOT NULL -- As ye mene khud kiya as vlaue year me null bhi aa rhi thi
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC; -- As hum badi company se dekhna chahte hai isliye


WITH Company_Year AS
(
SELECT company AS Company, YEAR(`date`) AS Release_Year ,SUM(total_laid_off) AS Per_Year_LayOffs
FROM layoffs_staging2
WHERE YEAR(`date`) IS NOT NULL -- As ye mene khud kiya as vlaue year me null bhi aa rhi thi
GROUP BY company, YEAR(`date`)
) -- EDA me CTEs ka hi mostly hum use krenege hum, Now we have data and we can access them in the select statement
-- SELECT *
-- FROM Company_Year; -- Ab ese sequence wise data me output aayega ese:- niche
/*
Company   Release_Year  Per_Year_LayOffs
 Amazon	   2022	         10150
 Amazon	   2023	         8000
*/
-- ___________Now we will see 2020,2021,2022 ke hisab se rank krenge kisne hihest nikala hai

SELECT *, -- This we extracted from the first CTE we created
DENSE_RANK() OVER(PARTITION BY Release_Year /*Year20,21,22,23*/ ORDER BY Per_Year_LayOffs DESC /*Highest Per Year Lays*/) AS Rankings_Per_Year
FROM Company_Year
ORDER BY Rankings_Per_Year ASC; -- Chote year se bade year tk rank krega
/* Company      Year   LayOffs Ranks
	Uber	    2020	7525	1       -- 2020,2021,2022,2023  ....hr saal me top ranked...1
	Bytedance	2021	3600	1       -- Then again per year ke hisab se 2020,2021,2022,2023.. second ranked ...2
	Meta	    2022	11000	1
	Google	    2023	12000	1
	Booking.com	2020	4375	2
	Katerra	    2021	2434	2
*/

-- If we want ranking like 2020,2020,2020,2020 -> 1,2 3,4

WITH Company_Year_Wise AS
(
SELECT company AS Company, YEAR(`date`) AS Release_Year ,SUM(total_laid_off) AS Per_Year_LayOffs
FROM layoffs_staging2
WHERE YEAR(`date`) IS NOT NULL -- As ye mene khud kiya as vlaue year me null bhi aa rhi thi
GROUP BY company, YEAR(`date`)
),
Company_Per_Year AS -- Looped CTE, this value from CTE -> Company_Year_Wise
(
SELECT *, DENSE_RANK() OVER(PARTITION BY Release_Year ORDER BY Per_Year_LayOffs DESC) AS Rankings
FROM Company_Year_Wise
),
Ranking_Wise AS -- We Can Make Multiple CTEs Based On Our Requirement, as at the end hum ek hi query bahar chala skte hai to hume cte he bnana padega
(SELECT *
FROM Company_Per_Year 
)
/* Company      Year   LayOffs Ranks
	Uber	    2020	7525	1       If we just have used:- SELECT * FROM Company_Per_Year 
	Booking.com	2020	4375	2                                       
	Groupon  	2020	2800	3
	Swiggy	    2020	2250	4
	Airbnb	    2020	1900	5
*/
SELECT *
FROM Ranking_Wise
WHERE Rankings <3;
/* Company      Year   LayOffs Ranks
	Uber	    2020	7525	1
	Booking.com	2020	4375	2      Here we are using the next looped CTE we created and fetching the date from there
	Bytedance	2021	3600	1
	Katerra	    2021	2434	2
	Meta	    2022	11000	1
*/





