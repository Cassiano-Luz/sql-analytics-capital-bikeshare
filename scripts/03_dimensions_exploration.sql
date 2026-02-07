/*
===============================================================================
Dimensions Exploration
===============================================================================

File: scripts/03_dimensions_exploration.sql

Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/



-- Retrieve a list of unique Member_Type
SELECT DISTINCT
    Member_Type
FROM capital_bikeshare.tb_bikes
ORDER BY Member_Type;
