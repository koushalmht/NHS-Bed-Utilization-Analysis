-- Check null values
SELECT
    COUNT(*) AS TotalRows,
    COUNT(Quarter) AS QuarterCount,
    COUNT(HB) AS HBCount,
    COUNT(Location) AS LocationCount,
    COUNT(Specialty) AS SpecialtyCount,
    COUNT(PercentageOccupancy) AS OccupancyCount
FROM dbo.beds_staging;

-- Check if occupancy values are valid
SELECT * 
FROM dbo.beds_staging
WHERE PercentageOccupancy > 100
OR PercentageOccupancy < 0;

-- Missing values on Specialty
-- TotalRows = 29930 but SpecialtyCount = 20058
-- 9,872 rows have missing specialty codes
-- Now, check if there are any duplicate rows
SELECT Quarter, HB, Location,SpecialtyName,
COUNT(*) AS Counting
FROM dbo.beds_staging
GROUP BY Quarter, HB, Location, SpecialtyName
HAVING COUNT(*) > 1 -- No duplicate rows found
ORDER BY Quarter -- Each rows represents unique combination

-- We have many columns ending with QF which are Metadata and some are completly empty
SELECT QuarterQF, HBQF, LocationQF, SpecialtyQF,
       SpecialtyNameQF, AllStaffedBeddaysQF, TotalOccupiedBeddaysQF,
       AverageAvailableStaffedBedsQF, AverageOccupiedBedsQF,
       PercentageOccupancyQF
FROM dbo.beds_staging

-- Remove these columns
ALTER TABLE dbo.beds_staging
DROP COLUMN QuarterQF, HBQF, LocationQF, SpecialtyQF,
            SpecialtyNameQF, AllStaffedBeddaysQF, TotalOccupiedBeddaysQF,
            AverageAvailableStaffedBedsQF, AverageOccupiedBedsQF,
            PercentageOccupancyQF

-- Check missing Specialty values
SELECT Quarter, HB, Location, Specialty, SpecialtyName, AllStaffedBeddays, TotalOccupiedBeddays
FROM dbo.beds_staging
WHERE Specialty IS NULL -- Actually, these rows are aggregated catogiries not missing values

SELECT DISTINCT SpecialtyName 
FROM dbo.beds_staging
WHERE Specialty IS NULL

-- Add a new column instead in order to analyze null values
ALTER TABLE dbo.beds_staging
ADD Specialty_Level VARCHAR(50) NULL;

ALTER TABLE dbo.beds_staging
ADD Specialty_Level AS(
    CASE
        WHEN Specialty IS NULL THEN 'Aggregated'
        ELSE 'Detailed'
    END
);


