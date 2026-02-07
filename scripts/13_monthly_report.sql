/*
===============================================================================
Monthly Report
===============================================================================

File: scripts/13_monthly_report.sql

Purpose:
    - To consolidate key monthly KPIs for Capital Bikeshare trips.

Highlights:
    1. Builds a clean monthly grain from raw trip-level data.
    2. Aggregates key monthly metrics:
       - total trips
       - total duration (hours)
       - average trip duration (minutes)
    3. Calculates performance KPIs:
       - Month-over-Month (MoM) change and MoM growth %
       - running totals (trips and duration)
       - share of total trips and duration (part-to-whole)
===============================================================================
*/

-- =============================================================================
-- Create Report View: capital_bikeshare.report_monthly
-- =============================================================================
DROP VIEW IF EXISTS capital_bikeshare.report_monthly;

CREATE VIEW capital_bikeshare.report_monthly AS
WITH monthly_base AS (
/*----------------------------------------------------------------------------
1) Base Monthly Aggregation: build month-level grain
----------------------------------------------------------------------------*/
SELECT
	DATE_FORMAT(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s'), '%Y-%m') AS `Year_Month`,
	COUNT(*) AS Number_Trips,
	SUM(Duration) / 3600 AS Total_Duration_Hr,
	AVG(Duration) / 60 AS Avg_Duration_Min
FROM capital_bikeshare.tb_bikes
WHERE STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s') IS NOT NULL
GROUP BY DATE_FORMAT(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s'), '%Y-%m')
),
monthly_metrics AS (
/*----------------------------------------------------------------------------
2) Monthly Metrics: add MoM and global totals
----------------------------------------------------------------------------*/
SELECT
	`Year_Month`,
	Number_Trips,
	Total_Duration_Hr,
	Avg_Duration_Min,
	LAG(Number_Trips) OVER (ORDER BY `Year_Month`) AS Prev_Month_Trips,
	LAG(Total_Duration_Hr) OVER (ORDER BY `Year_Month`) AS Prev_Month_Duration_Hr
FROM monthly_base
)
SELECT
	`Year_Month`,

	-- Core Metrics
	Number_Trips,
	ROUND(Total_Duration_Hr, 2) AS Total_Duration_Hr,
	ROUND(Avg_Duration_Min, 2) AS Avg_Duration_Min,

	-- MoM Performance (Trips)
	Prev_Month_Trips AS Prev_Month_Trips,
	(Number_Trips - Prev_Month_Trips) AS MoM_Trip_Change,
	ROUND(100 * (Number_Trips - Prev_Month_Trips) / NULLIF(Prev_Month_Trips, 0), 2) AS MoM_Trip_Growth_Pct,

	-- MoM Performance (Duration)
	ROUND(Prev_Month_Duration_Hr, 2) AS Prev_Month_Duration_Hr,
	ROUND((Total_Duration_Hr - Prev_Month_Duration_Hr), 2) AS MoM_Duration_Change_Hr,
	ROUND(100 * (Total_Duration_Hr - Prev_Month_Duration_Hr) / NULLIF(Prev_Month_Duration_Hr, 0), 2) AS MoM_Duration_Growth_Pct,

	-- Running Totals (Cumulative)
	SUM(Number_Trips) OVER (ORDER BY `Year_Month`) AS Running_Total_Trips,
	ROUND(SUM(Total_Duration_Hr) OVER (ORDER BY `Year_Month`), 2) AS Running_Total_Duration_Hr,

	-- Part-to-Whole (Share of Total)
	ROUND(100 * Number_Trips / NULLIF(SUM(Number_Trips) OVER (), 0), 2) AS Pct_Total_Trips,
	ROUND(100 * Total_Duration_Hr / NULLIF(SUM(Total_Duration_Hr) OVER (), 0), 2) AS Pct_Total_Duration

FROM monthly_metrics;

-- Preview
SELECT * FROM capital_bikeshare.report_monthly;
