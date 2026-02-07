/*
===============================================================================
Date Range Exploration 
===============================================================================

File: scripts/04_date_range_exploration.sql

Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/



-- Determine the first Start_Date, last End_Date and the total duration in months
SELECT 
    MIN(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s')) AS First_Start_Date,
    MAX(STR_TO_DATE(End_Date, '%Y-%m-%d %H:%i:%s')) AS Last_End_Date,
    TIMESTAMPDIFF(
		MONTH,
        MIN(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s')),
        MAX(STR_TO_DATE(End_Date, '%Y-%m-%d %H:%i:%s'))
	) AS Order_Range_Months
FROM capital_bikeshare.tb_bikes;
