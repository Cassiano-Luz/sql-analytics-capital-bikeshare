/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================

File: scripts/05_measures_exploration.sql

Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/



-- Find the total number of unique stations
SELECT
	COUNT(*) AS Nb_Stations
FROM (
	SELECT DISTINCT
		Start_Station_Number AS Station_Number,
		Start_Station AS Station_Name
	FROM capital_bikeshare.tb_bikes
	UNION
	SELECT DISTINCT
		End_Station_Number AS Station_Number,
		End_Station AS Station_Name
	FROM capital_bikeshare.tb_bikes
	ORDER BY Station_Number
)t;



-- Find the total number of bikes
SELECT
	COUNT(DISTINCT Bike_Number) AS Bike_Number
FROM capital_bikeshare.tb_bikes;



-- Find the average duration in seconds, minutes and hours
SELECT
	ROUND(AVG(Duration), 2) AS Avg_Duration_Sec,
    ROUND(AVG(Duration) / 60,2) AS Avg_Duration_Min,
    ROUND(AVG(Duration) / 3600,2) AS Avg_Duration_Hr
FROM capital_bikeshare.tb_bikes;
