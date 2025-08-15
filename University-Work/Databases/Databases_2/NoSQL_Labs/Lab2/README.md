# NoSQL Lab 2: MongoDB Exercises

## Overview
This project contains MongoDB scripts and exercises for **NoSQL Lab 2** at university.  
It demonstrates queries, aggregations, updates, and lookups on sample datasets including **cities**, **customers**, and **orders**.  

## Features
- **City Queries**: Retrieve cities by ID, coordinates, or population; perform regex searches.  
- **Customer & Orders Queries**: Aggregate customer and order data; use `$lookup` to join collections.  
- **Population Analysis**: Count cities by conditions; sort by population.  
- **Update Operations**: Add or modify document attributes safely.  
- **Practical MongoDB Links**: Uses aggregation, filters, regex, and other MongoDB operators.

## How to Run
Follow the steps below to execute the MongoDB queries:

### Step 1: Load the Dataset
1. Start the MongoDB server (\`mongod\`).  
2. Open the MongoDB shell (\`mongo\`) and select your database:
   \`\`\`bash
   use lab2_db
   \`\`\`

### Step 2: Run Queries
- Copy and paste commands from \`db2_queries.js\` into the shell to perform the exercises.  
- The queries include:
  - Finding cities by ID or coordinates
  - Counting cities by name or population
  - Aggregating orders with customer information
  - Updating documents and adding new attributes

## Prerequisites
- MongoDB installed and running  
- MongoDB shell (or a GUI like Compass)

## Notes
- Collections include \`citys\`, \`customers\`, \`orders\`, and \`s26\`.  
- Aggregation pipelines demonstrate \$match, \$lookup, and \$sort operators.  
- Updates use \$set to modify or add document attributes.
