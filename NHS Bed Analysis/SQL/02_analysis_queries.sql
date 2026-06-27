--Which NHS Boards experience the Highest occupancy and Lowest occupancy?
WITH agg_join AS(
SELECT
	d.NHS_Board_Name,
	SUM(CAST(f.TotalOccupiedBeddays AS BIGINT))* 100/SUM(CAST(f.AllStaffedBeddays AS BIGINT))
	AS Occupancy_Percentage
FROM analytics.beds_clean f
JOIN analytics.dim_nhs_board d
	ON f.HB = d.HB_Code
WHERE f.Location_Level = 'NHS Board Aggregated'
AND d.HB_Code <> 'S92000003'
GROUP BY d.NHS_Board_Name
),
Ranking AS(
SELECT
	NHS_Board_Name,
	Occupancy_Percentage,
	RANK() OVER(ORDER BY Occupancy_Percentage DESC) AS Highest_Rank,
	RANK() OVER(ORDER BY Occupancy_Percentage ASC) AS Lowest_Rank
FROM agg_join
)
SELECT
	NHS_Board_Name, Occupancy_Percentage, 
	CASE 
		WHEN Highest_Rank = 1 THEN 'Highest Occupancy' 
		WHEN Lowest_Rank = 1 THEN 'Lowest Occupancy'
	END AS Occupancy_Status
FROM Ranking
WHERE Highest_Rank = 1 OR Lowest_Rank = 1;
