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

Tools Used

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





