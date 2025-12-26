Advanced Level Queries

Focus: Analytical SQL and real-world insights

Examples:

Ranking patients by fever within cities

City with highest COVID positivity rate

Age-group risk analysis

Running totals of COVID-positive cases

Fever severity classification using CASE

Duplicate record detection

Skills demonstrated:

Window functions (RANK, COUNT OVER)

Common Table Expressions (CTEs)

Advanced filtering

Analytical reasoning
--Rank patients by fever temperature within each city.
--SELECT City, Age, Gender, Fever,
--RANK() OVER(PARTITION BY City ORDER BY Fever DESC)
--FROM covid_19;

--Identify the city with the highest COVID positivity rate.
SELECT TOP 1 City,
(COUNT(CASE WHEN Has_Covid = 'Yes' THEN 1 END) * 1.0 / COUNT(*)) AS positive_rate
FROM covid_19
GROUP BY City
ORDER BY City DESC;

--Find the age group (e.g., child <18, adult 18–60, senior >60) with the highest number of COVID-positive cases.
SELECT
CASE WHEN Age < 18 THEN 'child'
   WHEN Age BETWEEN 18 AND 60 THEN 'adult'
   ELSE 'senior' END AS age_group,
  COUNT(*) AS positive_cases
FROM covid_19
WHERE Has_Covid = 'Yes'
GROUP BY CASE WHEN Age < 18 THEN 'child'
   WHEN Age BETWEEN 18 AND 60 THEN 'adult'
   ELSE 'senior' END
ORDER BY positive_cases DESC;
  
--For each city, find the patient with the highest fever.
WITH fever_ranked AS(
  SELECT *,
  RANK () OVER(PARTITION BY CITY ORDER BY FEVER DESC) AS rnk
  FROM covid_19)
  
SELECT City, Age, Gender, Fever
FROM fever_ranked
WHERE rnk = 1;

--Determine whether higher fever correlates with COVID positivity (fever ranges)
SELECT
    CASE
        WHEN Fever < 100 THEN 'Normal'
        WHEN Fever BETWEEN 100 AND 101.9 THEN 'Mild'
        ELSE 'High'
    END AS fever_range,
    COUNT(*) AS total_patients,
    COUNT(CASE WHEN Has_Covid = 'Yes' THEN 1 END) AS positive_cases
FROM covid_19
GROUP BY
    CASE
        WHEN Fever < 100 THEN 'Normal'
        WHEN Fever BETWEEN 100 AND 101.9 THEN 'Mild'
        ELSE 'High'
    END;

--Calculate running totals of COVID-positive cases ordered by age
SELECT
    Age,
    COUNT(*) OVER (ORDER BY Age ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        AS running_total
FROM covid_19
WHERE Has_Covid = 'Yes';

--Identify duplicate patient records
SELECT
    Age,
    Gender,
    City,
    Fever,
    Cough,
    COUNT(*) AS duplicate_count
FROM covid_19
GROUP BY Age, Gender, City, Fever, Cough
HAVING COUNT(*) > 1;

--Compare average fever between COVID-positive and COVID-negative patients
SELECT
    Has_Covid,
    AVG(Fever) AS avg_fever
FROM covid_19
GROUP BY Has_Covid;

--Find cities where more than 30% of patients are COVID-positive
SELECT
    City,
    COUNT(CASE WHEN Has_Covid = 'Yes' THEN 1 END) * 1.0 / COUNT(*) AS positivity_rate
FROM covid_19
GROUP BY City
HAVING COUNT(CASE WHEN Has_Covid = 'Yes' THEN 1 END) * 1.0 / COUNT(*) > 0.30;

--Classify fever and analyze COVID positivity per category
SELECT
    CASE
        WHEN Fever < 100 THEN 'Normal'
        WHEN Fever BETWEEN 100 AND 101.9 THEN 'Mild'
        ELSE 'High'
    END AS fever_category,
    COUNT(*) AS total_patients,
    COUNT(CASE WHEN Has_Covid = 'Yes' THEN 1 END) AS positive_cases
FROM covid_19
GROUP BY
    CASE
        WHEN Fever < 100 THEN 'Normal'
        WHEN Fever BETWEEN 100 AND 101.9 THEN 'Mild'
        ELSE 'High'
    END;
