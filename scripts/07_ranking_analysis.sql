/*
===============================================================================
Ranking Analysis
===============================================================================

File: scripts/07_ranking_analysis.sql

Purpose:
    - To formally rank entities based on key performance metrics.
    - To identify top and bottom performers using explicit ranking logic.
    - To handle ordering, ties, and prioritization in a reproducible way.

This step builds on the Magnitude Analysis by:
    - Applying window ranking functions instead of simple ordering.
    - Making ranking rules explicit and auditable.

SQL Concepts Used:
    - Window Functions: RANK(), DENSE_RANK(), ROW_NUMBER()
    - Aggregate Functions: SUM(), COUNT()
    - GROUP BY, ORDER BY
===============================================================================
*/



-- Ranking by Bike - Which bikes rank highest by total trip duration?
WITH ranked AS (
  SELECT
    DENSE_RANK() OVER (ORDER BY SUM(Duration) DESC) AS Ranking,
    Bike_Number,
    ROUND(SUM(Duration) / 3600, 2) AS Duration_Hr
  FROM capital_bikeshare.tb_bikes
  GROUP BY Bike_Number
)
SELECT
	*
FROM ranked
WHERE Ranking <= 10
ORDER BY Ranking;



-- Ranking by Start Station - Which start stations rank highest by number of trips?
WITH ranked_st_station AS (
SELECT
	DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) AS Ranking,
	Start_Station_Number,
    Start_Station,
    COUNT(*) AS Number_Trips
FROM capital_bikeshare.tb_bikes
GROUP BY Start_Station_Number, Start_Station
)
SELECT
	Ranking,
	Start_Station_Number,
    Start_Station,
    Number_Trips
FROM ranked_st_station
WHERE Ranking <= 10;



-- Ranking by End Station - Which end stations rank lowest by number of trips?
WITH ranked_end_station AS (
SELECT
	DENSE_RANK() OVER(ORDER BY COUNT(*) ASC) AS Ranking,
	End_Station_Number,
    End_Station,
    COUNT(*) AS Number_Trips
FROM capital_bikeshare.tb_bikes
GROUP BY End_Station_Number, End_Station
)
SELECT
	Ranking,
	End_Station_Number,
    End_Station,
    Number_Trips
FROM ranked_end_station
WHERE Ranking <= 10;



-- Ranking by Month - Which months rank highest by number of trips?
WITH monthly AS (
  SELECT
    DATE_FORMAT(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s'), '%Y-%m') AS `Year_Month`,
    COUNT(*) AS Number_Trips
  FROM capital_bikeshare.tb_bikes
  GROUP BY DATE_FORMAT(STR_TO_DATE(Start_Date, '%Y-%m-%d %H:%i:%s'), '%Y-%m')
)
SELECT
  DENSE_RANK() OVER (ORDER BY Number_Trips DESC) AS Trip_Volume_Rank,
  `Year_Month`,
  Number_Trips
FROM monthly
ORDER BY Trip_Volume_Rank;



-- Ranking by Bike - How do bikes rank when trip counts are tied and total duration is used as a tie-breaker?
WITH rank_tie_breaker AS (
  SELECT
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC, SUM(Duration) DESC) AS Ranking,
    Bike_Number,
    COUNT(*) AS Number_Trips,
    ROUND(SUM(Duration) / 3600, 2) AS Duration_Hr
  FROM capital_bikeshare.tb_bikes
  GROUP BY Bike_Number
)
SELECT
	*
FROM rank_tie_breaker
WHERE Ranking <= 10
ORDER BY Ranking;
