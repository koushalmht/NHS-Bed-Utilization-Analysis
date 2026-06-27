-- Check null values for this column if any
-- On the other hand, available beds = 0 and occupied beds = 0
-- looks valid
SELECT *
FROM dbo.beds_staging
WHERE PercentageOccupancy IS NULL;

-- Both HB and Location column has same values 
-- like S08000016, S08000017 and so on
-- likely means Aggregated at NHS Board level

ALTER TABLE dbo.beds_staging
ADD Location_Level AS(
	CASE
		WHEN Location LIKE '%H' THEN 'Hospital'
		ELSE 'NHS Board Aggregated'
	END
);


