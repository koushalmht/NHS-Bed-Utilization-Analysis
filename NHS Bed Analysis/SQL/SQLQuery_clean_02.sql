-- Add useful business columns
-- Extract Year
ALTER TABLE analytics.beds_clean
ADD Year INT;

UPDATE analytics.beds_clean
SET Year = LEFT(Quarter,4);

SELECT * FROM analytics.beds_clean

-- Extract Quarter Number from Quarter column
ALTER TABLE analytics.beds_clean
ADD Quarter_Number INT;

UPDATE analytics.beds_clean
SET Quarter_Number = RIGHT(Quarter,1);

--Extract Quarter_Start_Date Column for time analysis
ALTER TABLE analytics.beds_clean
ADD Quarter_Start_Date DATE;
GO
UPDATE analytics.beds_clean
SET Quarter_Start_Date =
	CASE RIGHT(Quarter,2)
		WHEN 'Q1' THEN DATEFROMPARTS(CAST(LEFT(Quarter, 4) AS INT), 1, 1)
		WHEN 'Q2' THEN DATEFROMPARTS(CAST(LEFT(Quarter, 4) AS INT), 4, 1)
		WHEN 'Q3' THEN DATEFROMPARTS(CAST(LEFT(Quarter, 4) AS INT), 7, 1)
		WHEN 'Q4' THEN DATEFROMPARTS(CAST(LEFT(Quarter, 4) AS INT), 10, 1)
	END;

-- Validation checks
SELECT COUNT(*) -- 29930 rows
FROM analytics.beds_clean;

SELECT -- Check categories
	Occupancy_Category,
	COUNT(*) AS rowscount
FROM analytics.beds_clean
GROUP BY Occupancy_Category; -- Total rows 29930

SELECT -- Check years
	MIN(Year) AS FirstYear,
	MAX(Year) AS LastYear
FROM analytics.beds_clean;

SELECT TOP 10 -- Check quarter date
	Quarter,
	Quarter_Start_Date
FROM analytics.beds_clean



