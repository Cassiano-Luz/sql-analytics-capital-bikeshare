/*
===============================================================================
Part-to-Whole Analysis
===============================================================================

File: scripts/12_part_to_whole_analysis.sql

Purpose:
    - To understand how different categories contribute to overall metrics.
    - To quantify the relative share of each category in relation to the total.
    - To identify dominant segments and assess contribution concentration.

SQL Concepts Used:
    - Aggregate Functions: SUM(), COUNT()
    - Window Functions: SUM() OVER() for grand total calculations
    - Percentage calculations for share-of-total analysis
===============================================================================
*/

-- Part-to-Whole — What share of total trips and total ride duration is contributed by each member type?
WITH member_totals AS (
  SELECT
    Member_Type,
    COUNT(*) AS Number_Trips,
    SUM(Duration) / 3600 AS Total_Duration_Hr
  FROM capital_bikeshare.tb_bikes
  GROUP BY Member_Type
)
SELECT
  Member_Type,
  Number_Trips,
  ROUND(100 * Number_Trips / NULLIF(SUM(Number_Trips) OVER (), 0), 2) AS Pct_Total_Trips,
  ROUND(Total_Duration_Hr, 2) AS Total_Duration_Hr,
  ROUND(100 * Total_Duration_Hr / NULLIF(SUM(Total_Duration_Hr) OVER (), 0), 2) AS Pct_Total_Duration
FROM member_totals
ORDER BY Pct_Total_Trips DESC;



-- Part-to-Whole — How much of total trip volume is concentrated in the top 10 start stations?
WITH station_trips AS (
  SELECT
    Start_Station_Number,
    Start_Station,
    COUNT(*) AS Number_Trips
  FROM capital_bikeshare.tb_bikes
  GROUP BY Start_Station_Number, Start_Station
),
ranked AS (
  SELECT
    Start_Station_Number,
    Start_Station,
    Number_Trips,
    SUM(Number_Trips) OVER () AS Total_Trips_All,
    DENSE_RANK() OVER (ORDER BY Number_Trips DESC) AS Trip_Volume_Rank
  FROM station_trips
)
SELECT
  Trip_Volume_Rank,
  Start_Station_Number,
  Start_Station,
  Number_Trips,
  ROUND(100 * Number_Trips / NULLIF(Total_Trips_All, 0), 2) AS Pct_Total_Trips
FROM ranked
WHERE Trip_Volume_Rank <= 10
ORDER BY Trip_Volume_Rank;
