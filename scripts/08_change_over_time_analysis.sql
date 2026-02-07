/*
===============================================================================
Change Over Time Analysis
===============================================================================

File: scripts/08_change_over_time_analysis.sql

Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/


-- Change Over Time — Trip Volume and Duration
SELECT
	DATE_FORMAT(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s'), '%Y-%m') AS `Year_Month`,
	ROUND(SUM(Duration) / 3600, 2) AS Duration_Hr,
    ROUND(AVG(Duration) / 60, 2) AS Avg_Duration_Min,
    COUNT(*) AS Number_Trips
FROM capital_bikeshare.tb_bikes
GROUP BY DATE_FORMAT(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s'), '%Y-%m')
ORDER BY `Year_Month` ASC;



-- Change Over Time — Member Type Behavior
SELECT
	DATE_FORMAT(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s'), '%Y-%m') AS `Year_Month`,
    Member_Type,
	ROUND(SUM(Duration) / 3600, 2) AS Duration_Hr,
    ROUND(AVG(Duration) / 60, 2) AS Avg_Duration_Min,
    COUNT(*) AS Number_Trips
FROM capital_bikeshare.tb_bikes
GROUP BY DATE_FORMAT(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s'), '%Y-%m'), Member_Type
ORDER BY `Year_Month` ASC, Member_Type;
