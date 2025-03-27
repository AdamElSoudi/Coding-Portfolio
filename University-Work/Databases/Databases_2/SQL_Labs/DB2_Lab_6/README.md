# Databases 2 - Lab 6: Webshop Orders & Inventory

## Overview
This repository contains the SQL scripts for **Databases 2 - Lab 6** at university.  
The `01_lab_queries.sql` file contains my work, including table creation, queries, procedures, functions, triggers, and views for a webshop order system.

The ERD for this lab was provided by the university and can be found in the file `Lab6_ERD.png`, which was used to create the database structure.

## How to Run
Follow the steps below to set up and run the lab scripts:

### Step 1: Execute Queries
Run the `01_lab_queries.sql` file in MySQL Workbench or another MySQL-compatible tool.  
This script will:
- Create the necessary tables (`Customers`, `Orders`, `Items`, `Order_Items`, etc.)
- Implement required procedures for adding/removing items to orders, showing order details, and handling stock management
- Implement triggers and views for tracking low stock items and hot items
- Include a custom procedure, function, and trigger for extended functionality

## Prerequisites
- MySQL Workbench or any MySQL-compatible tool  
- Access to a MySQL server for running the queries  

## MySQL Settings
The following settings need to be applied:

- MySQL may be configured in **strict mode**  
- **Foreign key checks** must be **enabled**  
- Grouping should be set to **ONLY_FULL_GROUP_BY**  
