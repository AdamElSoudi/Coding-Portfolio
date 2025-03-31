# Databases 2 - Lab 4: Employees & Projects

## Overview
This repository contains the SQL scripts for **Databases 2 - Lab 4** at university.  
The `05_lab_queries.sql` file contains my work, while the table creation scripts and the initial data setups were provided by the university.

## Repository Structure
- `01_employees_data.sql`: Script for creating and populating the Employees table.
- `02_projects_data.sql`: Script for creating and populating the Projects table.
- `03_project-members_data.sql`: Initializes Project Members linkage table.
- `04_departments_data.sql`: Creates and populates the Departments table.
- `05_lab_queries.sql`: Contains all operational queries for implementing advanced database features.

## Features
- **Database Integrity and Constraints**: Introduces foreign key relationships with specific update and delete rules to maintain database integrity.
- **Index Optimization**: Implements indexing for faster query performance, particularly on employee last names and login fields.
- **Custom Triggers and Procedures**: From ensuring data integrity by preventing certain updates to creating automated responses to database events.
- **Data Type Optimization**: Refines SQL data types to enhance storage efficiency and performance.
- **Comprehensive Views and Functions**: Includes a variety of SQL views and functions that extend the functionality and querying capability of the database.

## How to Run
To set up and utilize the database scripts effectively, follow these steps:


### Step 1: Setup Database Schema
- **Employees and Projects**: Run `01_employees_data.sql` and `02_projects_data.sql` to prepare your database schema with necessary tables and initial data.

### Step 2: Link Tables and Insert Data
- **Linkages and More Data**: Execute `03_project-members_data.sql` and `04_departments_data.sql` to further populate the database and establish necessary relationships.

### Step 3: Execute Advanced Queries
- **Operational Queries**: Launch `05_lab_queries.sql` to run the series of predefined queries for database manipulation and management.

## Additional SQL Operations
- **Dynamic SQL Triggers**: Configure triggers to control data entry and update conditions, ensuring logical consistency throughout the database.
- **Security and Role-Based Access**: Implements security measures through triggers and role-based views to ensure data is accessible only to authorized roles.

## Prerequisites
- **MySQL Workbench** or a similar MySQL-compatible interface.
- An active **MySQL server** connection for executing SQL commands.

## MySQL Configuration
Ensure the following MySQL settings for optimal performance:
- **Strict SQL Mode**: Enforces strict SQL syntax and behaviors.
- **Foreign Key Checks**: Should be enabled to maintain referential integrity.
- **SQL Mode**: Set to `ONLY_FULL_GROUP_BY` to enforce full group by behavior in queries.
