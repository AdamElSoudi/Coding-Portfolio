# Databases 2 - Lab 6: Webshop Orders & Inventory

## Overview
This project contains the SQL scripts for building and managing a relational database for a fictional webshop system, including customers, orders, items, categories, and logs. The database supports operations for tracking inventory, logging item views, and managing order content.

All code is included in the `01_lab_queries.sql` file, which covers:
- Table creation based on the ERD provided
- Procedures for adding/removing items in orders
- Triggers for managing low-stock tracking
- Views for popular items and order summaries
- Custom procedures, functions, and materialized views based on an original extension to the ERD

## ER Diagram

The following ERD was provided as the foundation for this lab:

![ERD Diagram](https://raw.githubusercontent.com/AdamElSoudi/Coding-Portfolio/main/University-Work/Databases/Databases_2/SQL_Labs/DB2_Lab_6/Lab6_ERD.png)

## Repository Structure
- `01_lab_queries.sql`: Contains all SQL for table creation, data insertion, procedures, views, functions, triggers, and test queries.
- `Lab6_ERD.png`: Provided entity-relationship diagram used as a base for the database schema.

## Key Features
- **Inventory Management**: Automatically updates stock levels and tracks low inventory through triggers and a dedicated table.
- **Order System**: Orders can contain multiple items, and items can belong to multiple categories.
- **Item Logging**: Tracks how often each item is viewed using a log table and a dedicated view (`hot_items`).
- **Web-Ready Procedures**: Includes utility procedures like `show_order`, `add_item_to_order`, and `remove_item_from_order` for frontend integration.
- **Order History Reporting**: Procedure to view total order values over custom time ranges.
- **Custom Extensions**: Includes additional logic such as a new entity with supporting views, procedures, functions, and a materialized view.

## How to Run
1. Open `01_lab_queries.sql` in **MySQL Workbench** (or a compatible SQL client).
2. Execute the script to:
   - Create all necessary tables
   - Insert sample data (e.g. customers, items, orders, categories)
   - Create procedures, triggers, views, and functions for the webshop logic
3. Run the included test queries to verify the logic and functionality of the procedures and views.

## Prerequisites
- MySQL Workbench or any compatible SQL tool
- Access to a MySQL server

## MySQL Configuration
Make sure the following settings are applied before running the script:
- Foreign key checks: **Enabled**
- SQL mode: **ONLY_FULL_GROUP_BY** must be active
- MySQL may be running in **STRICT mode**
