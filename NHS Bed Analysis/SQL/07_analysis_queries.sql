-- Which regions(NHS Board) and specialties should be prioritized for resource allocation?
WITH resource_allocation AS(
	SELECT 
		d1.NHS_Board_Name,
		d2.Specialty_Name,
		ROUND(SUM(f.TotalOccupiedBeddays) * 100.0/
		NULLIF(SUM(f.AllStaffedBeddays), 0), 2) AS Occupancy_Percentage,
		ROUND(AVG(AverageAvailableStaffedBeds), 2) AS Avg_Available_Beds
	FROM analytics.beds_clean f
	JOIN analytics.dim_nhs_board d1
		ON f.HB = d1.HB_Code
	JOIN analytics.dim_specialty d2
		ON f.Specialty = d2.Specialty_Code
	WHERE f.Location_Level = 'NHS Board Aggregated'
		AND f.Specialty_Level = 'Detailed'
		AND d1.HB_Code != 'S92000003'
	GROUP BY d1.NHS_Board_Name, d2.Specialty_Name
)
SELECT
	NHS_Board_Name,
	Specialty_Name,
	Avg_Available_Beds,
	Occupancy_Percentage,
	RANK() OVER(ORDER BY Occupancy_Percentage DESC, Avg_Available_Beds ASC) AS Resource_Priority_Rank
FROM resource_allocation
ORDER BY Resource_Priority_Rank;
