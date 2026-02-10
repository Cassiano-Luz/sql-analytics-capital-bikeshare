# SQL Analytics — Capital Bikeshare

Welcome to the **SQL Analytics – Capital Bikeshare** repository.

This project presents a full **Exploratory and Advanced Analytics workflow in SQL**, built on top of **real-world trip data** from **Capital Bikeshare**, a large-scale urban mobility service in the United States.

Using over **3.7 million trip records from 2017**, the analysis transforms raw operational data into structured insights that support **business understanding, performance evaluation, and strategic decision-making**.

---

## 🚀 Project Scope

### Objective
Develop an end-to-end SQL analytics project, from **data exploration** to **advanced analytical reporting** to analyze bike-sharing usage patterns, performance trends, and user behavior using real operational data.

The project emphasizes:
- Analytical thinking
- Clean SQL design
- Business-oriented metrics
- Scalable analysis structure

---

## 📦 Dataset

- **Data Source**: Capital Bikeshare public trip data 🔗 https://s3.amazonaws.com/capitalbikeshare-data/index.html (Download File: 2017-capitalbikeshare-tripdata.zip)
- **Time range**: January–December 2017
- **Volume**: 3.7M+ trip records
- **Granularity**: One row per trip
- **Domain**: Urban mobility / transportation analytics

---

## 🧠 Analytical Structure

The repository is intentionally structured to reflect a **progressive analytics flow**, starting with **Exploratory Data Analysis (EDA)** and advancing into **higher-level analytical perspectives**.

### 🔍 Exploratory Data Analysis (EDA)

Focused on understanding the data shape, coverage, and consistency:

- Dimension exploration (stations, bikes, member types)
- Date range validation
- Measure inspection (duration, trip counts)
- Magnitude analysis
- Ranking (Top / Bottom entities)

### 📈 Advanced Analytics

Built on top of EDA insights to answer business-relevant questions:

- Change-over-time analysis (trends and seasonality)
- Cumulative growth (running totals)
- Performance analysis (Month-over-Month changes)
- Data segmentation using analytical logic
- Part-to-whole contribution analysis
- Analytical reporting views

---

## 📊 Analytics & Reporting (SQL)

The analytical outputs are delivered through **well-defined SQL queries and report views**, designed to be reusable and BI-ready.

Key deliverables include:

- **Monthly KPI Report**
  - Trip volume
  - Duration metrics
  - Month-over-Month (MoM) performance
  - Running totals
  - Share-of-total indicators

- **Member Type Behavior Report**
  - Member vs. casual usage patterns
  - Contribution to total trips and duration
  - Average trip behavior

All reports are implemented using **pure SQL**, leveraging:
- Window functions
- CTEs
- Analytical aggregations

These outputs are designed for **direct consumption by BI tools** or further analytical layers.

---

## 🔮 Future Enhancements

This project is intentionally designed to be extensible. Potential next steps include:

- Expanding the dataset to include additional years
- Performing **Year-over-Year (YoY)** analysis
- Creating interactive dashboards using BI tools (Power BI, Tableau)
- Automating data ingestion for recurring updates
- Applying query performance optimizations as data volume grows (e.g. indexing strategies, partitioning, materialized views)

These enhancements would support long-term trend analysis, scalability, and production-level analytics workloads.

---

## 🛡️ License

This project is licensed under the **MIT License**.  
You are free to use, modify, and share this project with proper attribution.

---

## 🌟 About Me

Hi! I'm **Cassiano Luz**, an engineer working with SQL, Python, and BI tools to analyze real-world data and build analytics solutions that support business decisions.  
*From data to directions.*

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Cassiano%20Luz-blue?style=for-the-badge&logo=linkedin)](https://www.linkedin.com/in/cassiano-luz/)
