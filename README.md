# Surf Rental & School Data Warehouse

## Project Overview
This project implements a complete **Business Intelligence (BI)** infrastructure for a surf rental and lesson company. It follows a structured data engineering pipeline, moving from a transactional database (OLTP) to a specialized Data Warehouse (OLAP) using a Star Schema architecture.

## Architecture & Data Pipeline
The project is divided into three main logical layers:

1. **Source (surfTX):** The operational database containing daily transactions, customers, instructors, and equipment rentals.
2. **Staging Area (surfSA):** - **EXT Layer:** Raw data extraction from source files and tables.
   - **TRA Layer:** Data cleaning and transformation. Includes handling of surrogate keys, time dimension generation, and logical joins to create dimensions.
3. **Data Warehouse (surfDW):** The final destination where the **Star Schema** resides, optimized for high-performance analytical queries.

## Technical Features
* **ETL Implementation:** Automated data movement scripts including `BULK INSERT` operations for large CSV datasets.
* **Star Schema Design:** - **Fact Table:** `reservasClases_h` (Class Reservations) capturing costs and operational metrics.
    - **Dimensions:** Includes `Time`, `Location`, `Instructor`, `Customer`, `Equipment Type`, and `Payment Method`.
* **Advanced SQL:** Usage of Window functions, CTEs (implied in transformations), and relational integrity enforcement through Primary and Foreign Keys.

## Tech Stack
* **Database Engine:** Microsoft SQL Server
* **Language:** T-SQL (Transact-SQL)
* **Modeling:** Dimensional Modeling (Star Schema)
