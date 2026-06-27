-- Which NHS Boards currenty have the greatest staffed bed capacity?
SELECT
	d.NHS_Board_Name,
	ROUND(f.AverageAvailableStaffedBeds, 2) AS Current_Available_Beds
FROM analytics.beds_clean f
JOIN analytics.dim_nhs_board d
	ON f.HB = d.HB_Code
WHERE f.Location_Level = 'NHS Board Aggregated'AND d.HB_Code != 'S92000003' AND
	  f.SpecialtyName = 'All Specialties' AND -- Each board has multiple specialty-level records so use aggregrated 'All Specialties'
	  f.Quarter = (
		SELECT MAX(Quarter)
		FROM analytics.beds_clean
		WHERE Location_Level = 'NHS Board Aggregated')
ORDER BY Current_Available_Beds DESC;