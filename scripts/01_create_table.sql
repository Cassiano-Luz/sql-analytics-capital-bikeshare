/*
=============================================================
Create Table: tb_bikes
=============================================================

File: scripts/01_create_table.sql

Script Purpose:

    - This script creates the table 'tb_bikes', which stores raw trip-level data
      related to bike usage in the Capital Bikeshare system.
    - Each record represents a single bike trip, including duration, start and end
      timestamps, station information, bike identifier, and member type.
    - If the table already exists, it is dropped and recreated to ensure a clean
      and reproducible schema state.

WARNING:
    - Running this script will DROP the existing 'tb_bikes' table if it exists.
    - All data stored in the table will be permanently deleted.
    - Use this script only in development, staging, or controlled environments.
    - Ensure you are connected to the correct database before executing this script.
*/


DROP TABLE IF EXISTS `tb_bikes`;
CREATE TABLE `tb_bikes` (
    `Duration` int DEFAULT NULL,
    `Start_Date` text,
    `End_Date` text,
    `Start_Station_Number` int DEFAULT NULL,
    `Start_Station` text,
    `End_Station_Number` int DEFAULT NULL,
    `End_Station` text,
    `Bike_Number` text,
    `Member_Type` text
);
