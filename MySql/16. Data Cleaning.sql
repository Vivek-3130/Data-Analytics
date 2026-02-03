-- DATA CLEANING
/*
Data cleaning in SQL is the process of identifying, correcting, or removing inaccurate, inconsistent,
or corrupt records from a dataset stored in a relational database. It ensures data is accurate, consistent, and reliable for analysis, reporting, and decision-making. 
*/

SELECT *
FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standardize The Data
-- 3. Null Values or Blank Values
-- 4. Remove Any Columns

CREATE TABLE layoffs_staging
LIKE layoffs; -- this will create a similar table like the layoffs, but there would be no data currently, ill have just the column names

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging -- insertion has been done to the the staging table
SELECT * FROM layoffs;

SELECT * FROM layoffs_staging;

--  ------------------------REMOVING DUPLICATES------------------------  --
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;
-- his query assigns a sequential row number to each record within groups of identical values using ROW_NUMBER() and is commonly used to
-- identify duplicate rows.(Basically similar rows jo hongi usne 1,2,3,4 ese dega row num and ise hum duplicates htyaenge)

-- We will create cte for easy use.
WITH duplicate_cte AS
(
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;
/*                                                                                               row_num
	Casper	New York City	Retail		   NULL NULL  9/14/2021	Post-IPO	United States	339	 2
	Cazoo	London	        Transportation 750	0.15  6/7/2022	Post-IPO	United Kingdom	2000 2
	Hibob	Tel Aviv	    HR	           70	0.3	  3/30/2020	Series A	Israel	        45	 2
*/
-- Now to see and verify we will check the name of the company as casper in normal layoff_staging file
SELECT *
FROM layoffs_staging
WHERE company = 'Cazoo';
/*
Cazoo	London	        Transportation NUll	NULL  6/7/2022	Post-IPO	United Kingdom	2000 2 --Not duplicate
Cazoo	London	        Transportation 750	0.15  6/7/2022	Post-IPO	United Kingdom	2000 2 -- Duplicate (we will remove this)
Cazoo	London	        Transportation 750	0.15  6/7/2022	Post-IPO	United Kingdom	2000 2 -- Not duplicate
*/
 -- Removing the duplicates
/*WITH duplicate_cte AS
(
SELECT * ,
ROW_NUMBER() OVER
(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date`, stage, country, funds_raised_millions) 
AS row_num
FROM layoffs_staging
)
DELETE -- We are removing the duplicates now , where ever the count number of row is more than 1
FROM duplicate_cte
WHERE row_num > 1; -- but hum cte me update statements use nhi kr skte we will make a diffeent table now having only row-numbers
*/

-- Creating new table having column as row_num
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` json DEFAULT NULL,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- Checking the structure of the table with the column name
SELECT *
FROM layoffs_staging2;
-- Inserting the data of layoffs_staging
INSERT INTO layoffs_staging2
SELECT * ,
ROW_NUMBER() OVER
(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date`, stage, country, funds_raised_millions) 
AS row_num
FROM layoffs_staging;
-- Excecuting the select statement
SELECT *
FROM layoffs_staging2
WHERE row_num > 1; -- All the duplicates will come
-- Now deleting them
DELETE 
FROM layoffs_staging2
WHERE row_num>1;
-- Again now checking the layoffs_staging2 wheather they are removed or not
SELECT *
FROM layoffs_staging2
WHERE row_num > 1; -- Nothing will come as there exist no duplictaes
-- Here the duplicate free table
SELECT *
FROM layoffs_staging2;

-- ------------------------STANDARDIZING TABLE----------------------- --


