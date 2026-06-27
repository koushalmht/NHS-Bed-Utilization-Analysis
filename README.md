# NHS-Bed-Utilization-Analysis
Project Overview

This project analyzes NHS Scotland inpatient bed availability and occupancy using SQL Server and Power BI.

The goal was to transform raw healthcare data into an analytical data model, perform business-focused SQL analysis, and build an interactive Power BI dashboard that supports healthcare capacity planning and resource allocation.

The project follows a modern analytics workflow:

Raw Data --> SQL Data Cleaning --> Star Schema Data Model --> SQL Business Analysis --> Power BI Dashboard

Dashboard Preview

Business Questions

This project answers the following analytical questions:

1) Which NHS Boards experience the Highest occupancy and Lowest occupancy?

2) Which NHS Boards has the highest and lowest average bed availability?

3) Which NHS Boards currently have the greatest staffed bed capacity?

4) Which specialties experience the greatest capacity pressure?

5) How have bed availability and occupancy changed over time by quarter?

6) How have bed availability and occupancy changed year over year?

7) Which regions (NHS Board) and specialties should be prioritized for resource allocation?

Tools Used:

SQL Server & SSMS --> Data cleaning, transformation and analysis

Power BI --> Dashboard development

Power Query --> Data loading & transformation

DAX --> Measures & KPIs

Data Model

This project uses Star Schema

dim_nhs_board

      |
      |
      
analytics.beds_clean

      |
      |                     
dim_specialty

Fact Table: analytics.beds_clean

Contains:

Quarter, HB, Location, Specialty, SpecialtyName, AllStaffedBeddays, TotalOccupiedBeddays, AverageAvailableStaffedBeds, AverageOccupiedbeds, PercentageOccupancy,
Specialty_Level, Location_Level, Occupancy_Category, Year, Quarter_Number, Quarter_Start_Date

Important Columns Description:

1) AllStaffedBeddays: The total no. of staffed bed-days available during a quarter. A staffed bed is a bed that has the necessary staff available to care for patients.
Example: Suppose a hospital has 100 staffed beds for an entire 90-day quarter.
Then, 100*90 = 9000 staffed bed-days

      Business Meaning: This represents the capacity available within hospitals

      Description: AllStaffedBeddays measures the total bed capacity available during a reporting period, expressed as staffed bed-days.

2) TotalOccupiedBeddays: The total no. of bed-days actually occupied by patients. Eg: If 100 beds available 80 occupied everyday, Then, 90 days in quarter 80*90 = 7200 occupied bed-days

      Business Meaning: this represents actual utilization of hospital capacity

      Description: It measures the total number of bed-days used by patients during the reporting period.

3) AverageAvailableStaffedBeds: Average number of staffed beds available per day during the quarter. i.e. AllStaffedBeddays/Number of days like 9000 staffed bed-days by 90 days results 100 beds.

      Business Meaning: Shows the average hospital capacity available on a daily basis.

      Description: It represents the average number of staffed beds available each day during the reporting period.

4) AverageOccupiedBeds: Avg. no of beds occupied each day. i.e. TotalOccupiedBeddays/ Number of days like 7200 occupied bed-days by 90 days results 80 occupied days.

      Business Meaning: Shows average patient demand and bed utilization

      Description: It represents the average number of beds occupied by patients each day during the reporting period.

5) Percentage Occupancy: The percentage of available beds occupied by patients. i.e. AverageOccupiedBeds/ AverageAvailableStaffedBeds * 100

      Business Meaning: This is the most important KPI for this data which measures capacity pressure, resource utilization and operational efficiency

      Description: It measures the proportion of available staffed beds occupied by patients and serves as the primary indicator of hospital capacity pressure

6) Specialty_Level & Location_Level: Since the dataset contains aggregated rows as well as non-aggregate, so need to seperate them before analysis.

Dimension Table: 
analytics.dim_nhs_board : HB(Board Code), NHS_Board_Name
analytics.dim_specialty: Specialty_Code, Specialty_Name

ETL Process:

The raw dataset was transformed through three SQL layers:

beds_raw --> beds_staging --> analytics.beds_clean

Data quality checks and cleaning tasks included:
Removing duplicates, checking null values, handeling missing values, creating business freindly categories, building dimension tables, preparing data for reporting

SQL Analysis:

SQL Analysis

Business-focused SQL queries were developed using:

CTEs, Window Functions(RANK(), DENSE_RANK(), LAG(), Aggregate Functions, CASE statements, Joins and so on.

Example analyses include:

NHS Board occupancy ranking

Capacity pressure analysis

Year-over-year occupancy changes

Resource allocation prioritization

Specialty occupancy comparison


Power BI Dashboard: The dashboard contains three analytical pages.

Executive Dashboard
Features:
Total Staffed Bed Days
Total Occupied Bed Days,
Overall Occupancy %,
Average Available Beds,
Occupancy Trend,
Occupancy by NHS Board,
Top Occupied Specialties,
Executive Insights

NHS Board Analysis
Includes:
Occupancy Rate by NHS Board
Average Bed Capacity by NHS Board,
Occupancy Status Table,
Interactive Year and Quarter filters

Specialty Analysis
Includes:
Occupancy Heat Map
Top Specialties by Occupancy,
Priority Areas for Resource Allocation,
Interactive filtering by NHS Board and Year

Key Insights

Overall bed occupancy remained consistently high throughout the study period.

Several NHS Boards regularly operated above the 85% occupancy threshold, indicating sustained capacity pressure.

Bed availability remained relatively stable, while occupancy increased over time.

Medical specialties generally experienced higher occupancy than surgical specialties.

Resource allocation should prioritize NHS Boards and specialties with both high occupancy and limited bed availability.

Skills Demonstrated

SQL: 
Data Cleaning,
ETL,
Star Schema Design,
Window Functions,
CTEs,
Ranking,
Time-Series Analysis,
Business KPI Development

Power BI: 
Data Modeling,
Relationships,
DAX Measures,
Interactive Dashboards,
Conditional Formatting,
Drill-through,
Slicers,
Executive Reporting

Data Analysis: 
Healthcare Analytics,
Capacity Planning,
Trend Analysis,
Performance Monitoring,
Resource Allocation









   












