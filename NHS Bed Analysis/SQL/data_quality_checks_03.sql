-- Adding occupancy category column
ALTER TABLE dbo.beds_staging
ADD Occupancy_Category VARCHAR(30);

UPDATE dbo.beds_staging
SET Occupancy_Category =
CASE
	WHEN PercentageOccupancy < 70 THEN 'Low Utilization'
	WHEN PercentageOccupancy <= 85 THEN 'Moderate'
	ELSE 'Capacity Pressure'
END;

