-- Which specialties experience the greatest capacity pressure.
WITH specialty_occupancy AS(
SELECT
	SpecialtyName,
	ROUND(
	SUM(TotalOccupiedBeddays) * 100.0/
	NULLIF(SUM(ALLStaffedBeddays), 0), 2) AS Occupancy_Percentage
FROM analytics.beds_clean
WHERE Specialty_Level = 'Detailed'
GROUP BY SpecialtyName
)
SELECT
	SpecialtyName, 
	Occupancy_Percentage,
	DENSE_RANK() OVER(ORDER BY Occupancy_Percentage DESC) AS Occupancy_Rank
FROM specialty_occupancy
ORDER BY Occupancy_Rank;