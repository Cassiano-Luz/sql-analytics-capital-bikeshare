/*
=============================================================
Load Data: tb_bikes
=============================================================

File: scripts/02_load_tb_bikes.sql

Script Purpose:

    - This script loads historical trip data from multiple CSV files into the
      'tb_bikes' table within the 'capital_bikeshare' database.
    - The CSV files represent quarterly Capital Bikeshare trip data for the year 2017
      (Q1 through Q4).
    - Each execution appends data to the existing 'tb_bikes' table.
    - The script assumes that the target table schema is already created and
      compatible with the structure of the input CSV files.

IMPORTANT:

    - The CSV file paths in this script are defined using absolute paths.
      Users must update the file paths in the LOAD DATA LOCAL INFILE statements
      to match the location of the CSV files on their local machine.
    - This script uses LOAD DATA LOCAL INFILE, which must be enabled on both
      the MySQL server and client.
    - When using MySQL Workbench, the connection must be configured with:
          OPT_LOCAL_INFILE=1
      (Edit Connection → Advanced → Others), otherwise you may get Error 2068.
    - If your CSV line endings are LF (\n) instead of CRLF (\r\n), update
      LINES TERMINATED BY accordingly.

WARNING:
    - Running this script will INSERT data into the 'tb_bikes' table.
    - If the script is executed multiple times without clearing the table,
      duplicate records will be inserted.
    - Enabling local_infile may require admin privileges and server configuration.
      If SET GLOBAL fails, enable it in the MySQL server configuration (my.ini)
      and restart the MySQL service.
    - Verify that you are connected to the correct database before executing
      this script.
*/


USE capital_bikeshare;

SHOW VARIABLES LIKE 'local_infile';
-- If OFF, enable local_infile in the server config (my.ini) or run SET GLOBAL (requires privileges).

LOAD DATA LOCAL INFILE 'C:/Users/Desktop/Desktop/INK/20-Estudos/portfolio/Capital_Bikeshare_Riding_the_Data/2017Q1-capitalbikeshare-tripdata.csv'
INTO TABLE capital_bikeshare.tb_bikes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/Desktop/Desktop/INK/20-Estudos/portfolio/Capital_Bikeshare_Riding_the_Data/2017Q2-capitalbikeshare-tripdata.csv'
INTO TABLE capital_bikeshare.tb_bikes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/Desktop/Desktop/INK/20-Estudos/portfolio/Capital_Bikeshare_Riding_the_Data/2017Q3-capitalbikeshare-tripdata.csv'
INTO TABLE capital_bikeshare.tb_bikes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/Desktop/Desktop/INK/20-Estudos/portfolio/Capital_Bikeshare_Riding_the_Data/2017Q4-capitalbikeshare-tripdata.csv'
INTO TABLE capital_bikeshare.tb_bikes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-- Basic validation
SELECT
	COUNT(*) AS total_rows_loaded
FROM capital_bikeshare.tb_bikes;
