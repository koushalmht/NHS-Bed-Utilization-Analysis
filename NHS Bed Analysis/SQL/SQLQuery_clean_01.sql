SELECT 
	Quarter,
	HB,
	Location,
	Specialty,
	SpecialtyName,
	AllStaffedBeddays,
	TotalOccupiedBeddays,
	AverageAvailableStaffedBeds,
	AverageOccupiedBeds,
	PercentageOccupancy,
	Specialty_Level,
	Location_Level,
	Occupancy_Category
INTO analytics.beds_clean
FROM beds_staging;
