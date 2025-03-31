# Databases 2 - Lab 2: Users, Friends, and Hobbies Database

## Overview
This database hosts SQL scripts for Lab 2 of the Databases 2 course, focusing on the relational interactions between users, their friends, and their hobbies. The `03_lab_queries.sql` contains my SQL queries, while the table structures and initial data setups were provided by the university.

## Repository Structure
- `01_create_tables.sql`: Contains SQL commands for creating user and hobby-related tables.
- `02_insert_data.sql`: Scripts to populate the tables with initial data.
- `03_lab_queries.sql`: Features SQL queries for manipulating and querying the data according to lab requirements.

## Features
- **Views Creation**: Includes views like `all_users` for user friendships and `friends_list` for individual user friends.
- **Dynamic Procedures**: Procedures for adding hobbies, users, and friendships enhance the interactivity of the database.

## How to Run
To utilize the database scripts effectively, follow these steps:

### Step 1: Setup Tables
- **Users and Hobbies**: Execute `01_create_tables.sql` to initialize the database schema for users and hobbies.
- **Data Insertion**: Run `02_insert_data.sql` to fill the tables with initial data, setting the stage for query operations.

### Step 2: Execute Queries
- **Operational Queries**: Launch `03_lab_queries.sql` to run the series of predefined queries and observe the database in action.

### Notable SQL Operations
- **Complex Queries**: Such as determining potential friends based on existing friendships and suggesting new friends through queries.

## Prerequisites
- **MySQL Workbench** or a similar MySQL-compatible interface.
- An active **MySQL server** connection for executing SQL scripts.
