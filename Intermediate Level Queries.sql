--Intermediate Level Queries

--Focus: Grouped analysis and business-style metrics

--Examples:

--Patients per city

--Average fever by gender

--COVID-positive cases per city

--COVID positivity percentage

--Grouping with HAVING

--Skills demonstrated:

--GROUP BY

--Conditional counting

--Percent calculations

--Multi-column aggregations

-- Count the number of patients per city.
SELECT City, COUNT(*) AS total_patients
FROM covid_19
GROUP BY City;

-- Calculate the average fever temperature by gender.
SELECT Gender, AVG(Fever)
FROM covid_19
GROUP BY Gender;

--Find the total number of COVID-positive cases per city.
SELECT City, COUNT(*) Covid_positive
FROM covid_19
WHERE Has_Covid = 'Yes'
GROUP BY City;

--Determine the percentage of patients who tested positive for COVID-19.
SELECT (COUNT(CASE WHEN Has_Covid = 'Yes' THEN 1 END) * 100.0/ COUNT(*)) AS positive_percentage
FROM covid_19;

-- Count COVID-positive and COVID-negative patients separately.
SELECT Has_Covid, COUNT(*) total_patients
FROM covid_19
GROUP BY Has_Covid;

-- Find the average age of patients who tested positive for COVID-19.
SELECT AVG(Age) AS Average_Age_positive
FROM covid_19
WHERE Has_Covid = 'Yes';

-- Identify cities where the average fever exceeds 101°F.
SELECT City, AVG(Fever)
FROM covid_19
GROUP BY City
HAVING AVG(Fever) > 101;

--Count the number of patients by cough severity.
SELECT Cough, COUNT (*) total_patients
FROM covid_19
GROUP BY Cough;

-- Find the city with the highest number of patients.
SELECT TOP 1 City, COUNT(*) total_patients
FROM covid_19
GROUP BY City
ORDER BY total_patients DESC

--Calculate the average fever temperature for each city and gender combination.
SELECT City, Gender, AVG(Fever) avg_fever
FROM covid_19
GROUP BY City, Gender;
