-- How have bed availability and occupancy changed year over year?
WITH yearly_agg AS(
	SELECT
		Year,
		ROUND(AVG(AverageAvailableStaffedBeds), 2) AS Avg_Available_Beds,
		ROUND(SUM(TotalOccupiedBeddays) * 100.0/
		NULLIF(SUM(ALLStaffedBeddays), 0), 2) AS Occupancy_Percentage
	FROM analytics.beds_clean
	WHERE Location_Level = 'NHS Board Aggregated' AND
	SpecialtyName = 'All Specialties'
	GROUP BY Year
),
absolute_change AS(
SELECT
	Year,
	Avg_Available_Beds, Occupancy_Percentage,
	LAG(Avg_Available_Beds) OVER(ORDER BY Year) AS Previous_Year_Beds,
	LAG(Occupancy_Percentage) OVER(ORDER BY Year) AS Previous_Year_Occupancy,
	(Avg_Available_Beds-LAG(Avg_Available_Beds) OVER(ORDER BY Year)) AS Bed_Change,
	(Occupancy_Percentage - LAG(Occupancy_Percentage) OVER(ORDER BY Year)) AS Occupancy_Change
FROM yearly_agg
),
percent_change AS(
	SELECT
		Year,
		Avg_Available_Beds,
		Bed_Change,
		ROUND(Bed_Change * 100.0/ NULLIF(Previous_Year_Beds, 0), 2) AS Bed_Change_Percent,
		Occupancy_Percentage,
		Occupancy_Change,
		ROUND(Occupancy_Change * 100.0/ NULLIF(Previous_Year_Occupancy, 0), 2) AS Occupancy_Change_Percent
	FROM absolute_change
)
SELECT * FROM percent_change



