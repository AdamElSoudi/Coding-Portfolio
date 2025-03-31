# Databases 2 - Lab 3: Users & Orders

## Overview
This repository contains the SQL scripts for **Databases 2 - Lab 3** at university, focusing on comprehensive SQL operations involving users and orders. The `03_lab_queries.sql` is my work, the tables and data was provided by the university.

## Repository Structure
- `01_users_data.sql`: Script to create and populate the Users table.
- `02_orders_data.sql`: Script to create and populate the Orders table.
- `03_lab_queries.sql`: Contains all operational queries for managing the database as per the lab's requirements.

## Features
- **Dynamic Queries**: Includes day-related operations using `now()` to determine specific weekdays for current and upcoming months.
- **Time-Sensitive Triggers**: Implements triggers that prevent future-dated entries, ensuring data integrity.
- **Custom Procedures and Functions**: Features user-created procedures for birthdays and a function to calculate age, enhancing the database's interactivity.

## How to Run
To deploy and use the database scripts, follow these instructions:

### Step 1: Setup Tables
- **Users**: Run `01_users_data.sql` to create user tables and insert initial data.
- **Orders**: Execute `02_orders_data.sql` to set up order tables and populate them with sample data.

### Step 2: Execute Queries
Run the `03_lab_queries.sql` file to execute the SQL queries that implement the required views and operations from the lab instructions.

### Notable Queries and Operations
- **Weekday Determination**: Queries to find out the weekday for the last day of the current month, the first day of the next month, and New Year's Eve 2025.
- **Lunch Countdown**: A procedure that shows how many minutes until noon.
- **Birthday Viewer**: A procedure that displays users with birthdays on specified days.
- **Age Calculation**: A function to calculate the user's age from the birthdate.

## Additional Notes
- **Database Security**: This lab incorporates essential security practices through the use of triggers and role-based data visibility.
- **Data Integrity**: Demonstrates maintenance of data integrity and timely data processing within a SQL environment.

## Prerequisites
- **MySQL Workbench** or any MySQL-compatible database management tool.
- Access to a **MySQL server** where you can execute SQL commands.
