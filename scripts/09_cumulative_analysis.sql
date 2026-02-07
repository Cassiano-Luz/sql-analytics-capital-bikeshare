/*
===============================================================================
Cumulative Analysis
===============================================================================

File: scripts/09_cumulative_analysis.sql

Purpose:
    - To calculate running totals for key metrics over time.
    - To analyze cumulative growth patterns and long-term trends.
    - To understand overall system adoption and usage progression.

SQL Concepts Used:
    - Window Functions: SUM() OVER()
===============================================================================
*/



-- Cumulative Trips & Duration Over Time - How do the total number of trips and total ride duration accumulate over time?
SELECT
	`Year_Month`,
    Total_Duration_Hr,
	ROUND(SUM(Total_Duration_Hr) OVER(ORDER BY `Year_Month`), 2) AS Running_Total_Duration_Hr,
    Number_Trips,
    ROUND(SUM(Number_Trips) OVER(ORDER BY `Year_Month`), 2) AS Running_Number_Trips
FROM
(
    SELECT 
        DATE_FORMAT(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s'), '%Y-%m') AS `Year_Month`,
        SUM(Duration) / 3600 AS Total_Duration_Hr,
        COUNT(*) AS Number_Trips
    FROM capital_bikeshare.tb_bikes
    GROUP BY DATE_FORMAT(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s'), '%Y-%m')
) t;
