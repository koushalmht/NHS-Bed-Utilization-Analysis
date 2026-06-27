-- Executive KPIs
-- Total Staffed Bed Days
SELECT 
	SUM(AllStaffedBeddays) AS Total_Staffed_Bed_Days,
	SUM(TotalOccupiedBeddays) AS Total_Occupied_Bed_Days
FROM analytics.beds_clean;

-- Average Occupancy
SELECT
	ROUND(AVG(PercentageOccupancy), 2) AS Avg_Occupancy_percentage
FROM analytics.beds_clean;

-- Number of NHS Boards
SELECT
	COUNT(DISTINCT HB) AS Total_NHS_Boards
FROM analytics.beds_clean;

-- Number of Specialties
SELECT
	COUNT(DISTINCT SpecialtyName) AS Total_Specialties
FROM analytics.beds_clean
WHERE Specialty_Level = 'Detailed';

SELECT * FROM analytics.beds_clean