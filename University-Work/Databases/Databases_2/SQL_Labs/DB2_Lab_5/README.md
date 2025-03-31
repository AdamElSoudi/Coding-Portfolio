# Databases 2 - Lab 5: Accounts & Transactions

## Overview
This project contains SQL scripts for **Databases 2 - Lab 5** at university that implement a basic banking system. The database supports multiple users, shared bank accounts, transaction logging, and includes constraints to ensure that accounts never drop below zero. The `01_lab_queries.sql` file contains my work, including table creation, queries, procedures, functions, and roles.

## Features
- **Multi-Owner Accounts**: An account can be owned by one or more users.
- **Deposit & Withdraw Procedures**: Safely handle account balances using transaction blocks.
- **Transfers Logging**: All deposits and withdrawals are automatically logged with timestamp and notes.
- **Ownership View**: Displays which users own which accounts.
- **Ownership Count Function**: Returns how many users are associated with a given account.
- **Transfer History Procedure**: Returns transaction history for a specific account.
- **Security Logic**: Ensures users can’t overdraw or deposit invalid amounts.
- **Access Control**: MySQL users, roles, grants, and revokes are implemented for database security.

## How to Run
Follow the steps below to set up and run the lab scripts:

### Step 1: Execute Queries
Run the `01_lab_queries.sql` file in MySQL Workbench or another MySQL-compatible tool.  
This script will:
- Create the necessary tables (`Users`, `Accounts`, `Transfers`, `Owners`)
- Insert sample data for users and accounts
- Implement required views, procedures, functions, transactions, user roles, and permissions

## Prerequisites
- MySQL Workbench or any MySQL-compatible tool  
- Access to a MySQL server for running the queries  

## MySQL Settings
The following settings need to be applied:

- MySQL may be configured in **strict mode**  
- **Foreign key checks** must be **enabled**  
- Grouping should be set to **ONLY_FULL_GROUP_BY**  
