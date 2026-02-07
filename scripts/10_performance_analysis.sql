/*
===============================================================================
Performance Analysis (Month-over-Month)
===============================================================================

File: scripts/10_performance_analysis.sql

Purpose:
    - To measure performance changes over time using month-over-month comparison.
    - To identify growth, decline, or stability in trip volume.
    - To benchmark monthly performance against the overall average.

SQL Functions Used:
    - LAG(): Accesses data from the previous month.
    - AVG() OVER(): Computes the overall average for benchmarking.
    - SUM() OVER(): Calculates cumulative performance.
    - CASE: Classifies performance trends.
===============================================================================
*/



-- Performance Over Time - How does trip volume change month over month, and how does each month perform compared to the overall average?
WITH monthly_trips AS (
SELECT
	DATE_FORMAT(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s'), '%Y-%m') AS `Year_Month`,
    COUNT(*) AS Number_Trips
FROM capital_bikeshare.tb_bikes
GROUP BY DATE_FORMAT(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s'), '%Y-%m')
),
metrics AS (
SELECT
	`Year_Month`,
    Number_Trips,
    LAG(Number_Trips) OVER (ORDER BY `Year_Month`) AS Prev_Month_Trips,
    AVG(Number_Trips) OVER () AS Avg_Trips_All
FROM monthly_trips
)
SELECT
	`Year_Month`,
    Number_Trips,
    Prev_Month_Trips,
    (Number_Trips - Prev_Month_Trips) AS Diff_Monthly,
	CASE
		WHEN Prev_Month_Trips IS NULL THEN 'N/A'
		WHEN (Number_Trips - Prev_Month_Trips) > 0 THEN 'Increase'
		WHEN (Number_Trips - Prev_Month_Trips) < 0 THEN 'Decrease'
    ELSE 'No Change'
	END AS Status,
	ROUND(100 * (Number_Trips - Prev_Month_Trips) / NULLIF(Prev_Month_Trips, 0),2) AS Growth_Percent,
	ROUND(Avg_Trips_All, 0) AS Avg_Trips,
	CASE
		WHEN Number_Trips > Avg_Trips_All THEN 'Above Avg'
		WHEN Number_Trips < Avg_Trips_All THEN 'Below Avg'
	ELSE 'Avg'
	END AS Avg_Status,
    SUM(Number_Trips) OVER(ORDER BY `Year_Month`) AS Accumulated
FROM metrics
ORDER BY `Year_Month`;
