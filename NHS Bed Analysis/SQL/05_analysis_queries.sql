-- How have bed availability and occupancy changed over time by quarter?
SELECT 
	Quarter,
	Quarter_Start_Date,
	ROUND(AVG(AverageAvailableStaffedBeds), 2) AS Avg_Available_Beds,
	ROUND(SUM(TotalOccupiedBeddays) * 100.0/
	NULLIF(SUM(ALLStaffedBeddays), 0), 2) AS Occupancy_Percentage
FROM analytics.beds_clean
WHERE Location_Level = 'NHS Board Aggregated' AND
	  SpecialtyName = 'All Specialties'
GROUP BY Quarter, Quarter_Start_Date
ORDER BY Quarter_Start_Date;

