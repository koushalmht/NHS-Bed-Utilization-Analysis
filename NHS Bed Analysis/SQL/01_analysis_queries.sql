-- Which NHS Boards has the highest and lowest average bed availability
WITH available_beds AS(
SELECT d.NHS_Board_Name,
	ROUND(AVG(f.AverageAvailableStaffedBeds), 2) AS Avg_Available_Beds
FROM analytics.beds_clean f
JOIN analytics.dim_nhs_board d
ON f.HB = d.HB_Code
WHERE Location_Level = 'NHS Board Aggregated'
AND HB_Code != 'S92000003' -- Removing this from filter because it belongs to Scotland not NHS Board
GROUP BY d.NHS_Board_Name
),
ranking AS(
SELECT 
	NHS_Board_Name, Avg_Available_Beds,
	RANK() OVER(ORDER BY Avg_Available_Beds DESC) AS Highest_Rank,
	RANK() OVER(ORDER BY Avg_Available_Beds ASC) AS Lowest_Rank
FROM available_beds
)
SELECT
	NHS_Board_Name, Avg_Available_Beds,
	CASE
		WHEN Highest_Rank = 1 THEN 'Highest Availability'
		WHEN Lowest_Rank = 1 THEN 'Lowest Availability'
	END AS Availability_Status
FROM ranking
WHERE Highest_Rank = 1 OR Lowest_Rank = 1;


