/*
===============================================================================
Member Type Report
===============================================================================

File: scripts/14_member_type_report.sql

Purpose:
    - To consolidate key trip behavior metrics by member type (e.g., Member vs Casual).

Highlights:
    1. Aggregates member-type metrics:
       - total trips
       - total duration (hours)
       - average duration (minutes)
    2. Calculates share-of-total KPIs (part-to-whole):
       - % of total trips
       - % of total duration
===============================================================================
*/

-- =============================================================================
-- Create Report View: capital_bikeshare.report_member_type
-- =============================================================================
DROP VIEW IF EXISTS capital_bikeshare.report_member_type;

CREATE VIEW capital_bikeshare.report_member_type AS
WITH member_totals AS (
  SELECT
    Member_Type,
    COUNT(*) AS Number_Trips,
    SUM(Duration) / 3600 AS Total_Duration_Hr,
    AVG(Duration) / 60 AS Avg_Duration_Min
  FROM capital_bikeshare.tb_bikes
  WHERE Duration > 0 AND Member_Type IS NOT NULL
  GROUP BY Member_Type
)
SELECT
  Member_Type,
  Number_Trips,
  ROUND(100 * Number_Trips / NULLIF(SUM(Number_Trips) OVER (), 0), 2) AS Pct_Total_Trips,
  ROUND(Total_Duration_Hr, 2) AS Total_Duration_Hr,
  ROUND(100 * Total_Duration_Hr / NULLIF(SUM(Total_Duration_Hr) OVER (), 0), 2) AS Pct_Total_Duration,
  ROUND(Avg_Duration_Min, 2) AS Avg_Duration_Min
FROM member_totals;

-- Preview
SELECT
	*
FROM capital_bikeshare.report_member_type
ORDER BY Number_Trips DESC;
