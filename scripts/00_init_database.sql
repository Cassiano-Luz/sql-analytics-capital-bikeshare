/*
===============================================================================
Init Database
===============================================================================
File: scripts/00_init_database.sql

Script Purpose:
    - Creates a clean and reproducible MySQL database environment for the project.
    - Drops the existing 'capital_bikeshare' database (if it exists) and recreates it
      using UTF8MB4 encoding for full Unicode support.

WARNING:
    - Running this script will DROP the entire 'capital_bikeshare' database if it exists.
    - All objects and data in the database will be permanently deleted.
    - Use only in development/staging or controlled environments.
===============================================================================
*/



/*
=============================================================
Create Database
=============================================================
*/
-- Drop and recreate the DATABASE IF EXISTS "capital_bikeshare"
DROP DATABASE IF EXISTS capital_bikeshare;
CREATE DATABASE capital_bikeshare
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;
USE capital_bikeshare;
