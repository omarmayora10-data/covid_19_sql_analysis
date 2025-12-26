Beginner Level Queries

Focus: Basic SELECT statements, filtering, and simple aggregations

Examples:

Retrieve all patient records

Count total patients

Filter COVID-positive cases

Find patients by city or gender

Basic WHERE, COUNT, and DISTINCT usage

Skills demonstrated:

Data exploration

Filtering

Simple aggregations


-- Retrieving all the records from covid_19 table
--SELECT *
--FROM covid_19;

-- Count the total number of patients in the dataset.
SELECT COUNT(*) AS Total_rows
FROM covid_19;

-- Missing values in gender, cough, has_covid
SELECT Gender, Cough, Has_Covid
FROM covid_19
WHERE Gender IS NULL AND Cough IS NULL AND Has_Covid IS NULL;

-- Unique categories in gender
SELECT DISTINCT Gender
FROM covid_19;

--Unique categories in cough
SELECT DISTINCT Cough
FROM covid_19;

-- List all Unique cities present in the dataset
SELECT DISTINCT City
FROM covid_19;

-- Find the youngest and oldest patient ages.
SELECT MIN(Age) AS youngest_age, 
  MAX(Age) AS oldest_age
FROM covid_19;

--List patients whose age is below 18.
--SELECT *
--FROM covid_19
--WHERE Age < 18;

-- Show all patients who tested positive for COVID-19
--SELECT *
--FROM covid_19
--WHERE Has_Covid = 'Yes'

-- Retrieve patients whose fever is greater than 101°F.
--SELECT *
--FROM covid_19
--WHERE Fever > 101

--Find all female patients from Delhi.
--SELECT *
--FROM covid_19
--WHERE Gender = 'Female' AND City = 'Delhi';

--Display patients who have a Strong cough.
--SELECT *
--FROM covid_19
--WHERE Cough = 'Strong';

-- Retrieve all patients from Mumbai with a fever above 100°F.
--SELECT *
--FROM covid_19
--WHERE FEVER < 100;