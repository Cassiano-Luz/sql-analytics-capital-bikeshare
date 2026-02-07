/*
===============================================================================
Data Segmentation Analysis
===============================================================================

File: scripts/11_data_segmentation.sql

Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/



-- Data Segmentation — How are trips distributed across short/medium/long duration segments and detailed duration buckets?
WITH classified AS (
SELECT
	Duration,
	CASE
		WHEN Duration IS NULL OR Duration <= 0 THEN 'Invalid/Unknown'
		WHEN Duration <= 300 THEN '00-05 min'
        WHEN Duration <= 600  THEN '05-10 min'
        WHEN Duration <= 900  THEN '10-15 min'
        WHEN Duration <= 1200 THEN '15-20 min'
        WHEN Duration <= 1500 THEN '20-25 min'
        WHEN Duration <= 1800 THEN '25-30 min'
	ELSE '30+ min'
    END AS Duration_Bucket,
    CASE
		WHEN Duration IS NULL OR Duration <=0 THEN 'Invalid/Unknown'
		WHEN Duration <= 600  THEN 'Short'   -- 10 min
		WHEN Duration <= 1800 THEN 'Medium'  -- 10–30 min
	ELSE 'Long'
    END AS Duration_Segment
FROM capital_bikeshare.tb_bikes
)
SELECT
	Duration_Segment,
    Duration_Bucket,
    COUNT(*) AS Number_Trips
FROM classified
GROUP BY Duration_Segment, Duration_Bucket
ORDER BY
	FIELD(Duration_Segment, 'Short', 'Medium', 'Long', 'Invalid/Unknown'),
    Duration_Bucket;



-- Data Segmentation - How does trip activity vary by time-of-day segments (morning,afternoon, evening, night)?
WITH classified AS (
SELECT
	HOUR(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s')) AS Hour_Column,
	CASE
		WHEN HOUR(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s')) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN HOUR(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s')) BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN HOUR(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s')) BETWEEN 17 AND 21 THEN 'Evening'
	ELSE 'Night'
    END AS Time_Segment,
    CASE
      WHEN HOUR(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s')) BETWEEN 5 AND 11 THEN 1
      WHEN HOUR(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s')) BETWEEN 12 AND 16 THEN 2
      WHEN HOUR(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s')) BETWEEN 17 AND 21 THEN 3
      ELSE 4
    END AS Segment_Order
FROM capital_bikeshare.tb_bikes
)
SELECT
	Time_Segment,
    COUNT(*) AS Number_Trips
FROM classified
GROUP BY Time_Segment, Segment_Order
ORDER BY Segment_Order;



-- Data Segmentation — How are bikes distributed across usage intensity segments (low, medium, high) based on trip counts?
WITH bike_trips AS (
SELECT
	Bike_number,
    COUNT(*) AS Number_Trips
FROM capital_bikeshare.tb_bikes
GROUP BY Bike_number
),
classified AS (
SELECT
	Bike_number,
    Number_Trips,
    CASE
		WHEN Number_Trips > 0 AND Number_Trips < 750 THEN 'Low'
        WHEN Number_Trips >= 750 AND Number_Trips < 1200 THEN 'Medium'
	ELSE 'High'
    END AS Status
FROM bike_trips
)
SELECT
    Status,
	COUNT(*) AS Number_Trips,
    ROUND(AVG(Number_Trips), 0) AS Avg_Trips_Per_Bike
FROM classified
GROUP BY Status
ORDER BY FIELD(Status, 'Low', 'Medium', 'High');



-- Data Segmentation — How are trips distributed across short, medium, and long duration segments for each member type?
WITH classified AS (
SELECT
    Member_Type,
    CASE
		WHEN Duration IS NULL OR Duration <= 0 THEN 'Invalid/Unknown'
		WHEN Duration <= 600 THEN 'Short'
        WHEN Duration <= 1800 THEN 'Medium'
	ELSE 'Long'  
    END AS Duration_Segment
FROM capital_bikeshare.tb_bikes
)
SELECT
    Member_Type,
	Duration_Segment,
	COUNT(*) AS Number_Trips
FROM classified
GROUP BY Member_Type, Duration_Segment
ORDER BY 
	Member_Type,
    FIELD(Duration_Segment, 'Short', 'Medium', 'Long', 'Invalid/Unknown');
