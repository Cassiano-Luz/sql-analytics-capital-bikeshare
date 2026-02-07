/*
===============================================================================
Magnitude Analysis
===============================================================================

File: scripts/06_magnitude_analysis.sql

Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.

SQL Concepts Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY, LIMIT
    - CTEs (WITH) and Window Functions (OVER) for share-of-total metrics
===============================================================================
*/



-- Magnitude by Member_Type - Trips and duration by member type
SELECT
  Member_Type,
  COUNT(*) AS Number_Trips,
  ROUND(SUM(Duration) / 3600, 2) AS Total_Duration_Hr,
  ROUND(AVG(Duration) / 60, 2) AS Avg_Duration_Min
FROM capital_bikeshare.tb_bikes
GROUP BY Member_Type
ORDER BY Number_Trips DESC;



-- Magnitude by Start Station - Top start stations by trip volume (with duration context)
SELECT
  Start_Station_Number,
  Start_Station,
  COUNT(*) AS Number_Trips,
  ROUND(SUM(Duration) / 3600, 2) AS Total_Duration_Hr,
  ROUND(AVG(Duration) / 60, 2) AS Avg_Duration_Min
FROM capital_bikeshare.tb_bikes
GROUP BY Start_Station_Number, Start_Station
ORDER BY Number_Trips DESC, Total_Duration_Hr DESC
LIMIT 10;



-- Magnitude by End Station - Top end stations by trip volume (with duration context)
SELECT
  End_Station_Number,
  End_Station,
  COUNT(*) AS Number_Trips,
  ROUND(SUM(Duration) / 3600, 2) AS Total_Duration_Hr,
  ROUND(AVG(Duration) / 60, 2) AS Avg_Duration_Min
FROM capital_bikeshare.tb_bikes
GROUP BY End_Station_Number, End_Station
ORDER BY Number_Trips DESC, Total_Duration_Hr DESC
LIMIT 10;



-- Magnitude by Bike - Total duration and trip counts by bike (Top 10 by duration)
SELECT
  Bike_Number,
  COUNT(*) AS Number_Trips,
  ROUND(SUM(Duration) / 3600, 2) AS Total_Duration_Hr,
  ROUND(AVG(Duration) / 60, 2) AS Avg_Duration_Min
FROM capital_bikeshare.tb_bikes
GROUP BY Bike_Number
ORDER BY Total_Duration_Hr DESC, Number_Trips DESC
LIMIT 10;



-- Magnitude by Month - Monthly trips and total duration (trend-ready aggregation)
SELECT
  DATE_FORMAT(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s'), '%Y-%m') AS `Year_Month`,
  COUNT(*) AS Number_Trips,
  ROUND(SUM(Duration) / 3600, 2) AS Total_Duration_Hr,
  ROUND(AVG(Duration) / 60, 2) AS Avg_Duration_Min
FROM capital_bikeshare.tb_bikes
GROUP BY DATE_FORMAT(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s'), '%Y-%m')
ORDER BY `Year_Month`;
