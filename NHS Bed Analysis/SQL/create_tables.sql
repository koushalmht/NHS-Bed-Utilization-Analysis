--CREATE SCHEMA analytics;
--GO
-- Create table inorder to show NHS Board codes to its NHS Board Name
CREATE TABLE analytics.dim_nhs_board(
	HB_Code VARCHAR(20) PRIMARY KEY,
	NHS_Board_Name VARCHAR(100)
);
INSERT INTO analytics.dim_nhs_board
VALUES
('S08000015','NHS Ayrshire and Arran'),
('S08000016','NHS Borders'),
('S08000017','NHS Dumfries and Galloway'),
('S08000019','NHS Forth Valley'),
('S08000020','NHS Grampian'),
('S08000022','NHS Highland'),
('S08000024','NHS Lothian'),
('S08000025','NHS Orkney'),
('S08000026','NHS Shetland'),
('S08000028','NHS Western Isles'),
('S08000029','NHS Fife'),
('S08000030','NHS Tayside'),
('S08000031','NHS Greater Glasgow and Clyde'),
('S08000032','NHS Lanarkshire'),
('S92000003','Scotland'),
('SB0801','Special Board');

CREATE TABLE analytics.dim_specialty(
	Specialty_Code VARCHAR(50),
	Specialty_Name VARCHAR(225)
);

INSERT INTO analytics.dim_specialty
(
	Specialty_Code,
	Specialty_Name
)
SELECT DISTINCT
	Specialty,
	SpecialtyName
FROM analytics.beds_clean
WHERE Specialty IS NOT NULL;

ALTER TABLE analytics.dim_specialty
ADD CONSTRAINT PK_dim_specialty
PRIMARY KEY(Specialty_Code);

DROP TABLE IF EXISTS analytics.dim_specialty;
SELECT DISTINCT
    Specialty AS Specialty_Code,
    SpecialtyName AS Specialty_Name
INTO analytics.dim_specialty
FROM analytics.beds_clean;

SELECT * FROM analytics.dim_specialty
ORDER BY Specialty_Name;

DROP TABLE IF EXISTS analytics.dim_specialty;

WITH specialties AS(
SELECT DISTINCT
	Specialty,
	SpecialtyName
FROM analytics.beds_clean)

SELECT
	ROW_NUMBER() OVER (ORDER BY SpecialtyName) AS Specialty_Key,
	Specialty AS Specialty_Code,
	SpecialtyName AS Specialty_Name
	INTO analytics.dim_specialty
	FROM specialties;

SELECT TOP 20 *
FROM analytics.dim_specialty
ORDER BY Specialty_Name;
