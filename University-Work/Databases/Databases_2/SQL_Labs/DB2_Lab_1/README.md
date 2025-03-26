# Databases 2 - Lab 1: Movie Database

## Overview
This repository contains the SQL scripts for **Databases 2 - Lab 1** at university. The lab focuses on creating a movie database schema, inserting sample data, and writing SQL queries for various tasks such as creating views, joining tables, and aggregating data.

## How to Run
Follow the steps below to set up and run the lab scripts:

### Step 1: Create Tables
Run the `01_create_tables.sql` file in your MySQL Workbench to create the necessary tables for the movie database. This includes tables for `Movies`, `Genres`, and `MoviesGenres`.

### Step 2: Insert Sample Data
Run the `02_insert_data.sql` file to insert the sample data into the created tables. This will populate the database with movie records, genre types, and the relationships between movies and genres.

### Step 3: Execute Queries
Run the `03_lab_queries.sql` file to execute the SQL queries that implement the required views and operations from the lab instructions. These queries include:
- Creating views for movie genres, top-rated movies, genre counts, and more.
- Performing aggregate operations like calculating average ratings per genre.

## Queries Overview
The following SQL views and queries were created as part of this lab:

1. **MovieGenre** - A view that lists all movies and their associated genre.
2. **MoviesYears** - A view that lists movie titles with their release year, sorted alphabetically.
3. **TopRated** - A view that filters and lists only movies with ratings of 8 or higher.
4. **GenreCount** - A view that counts the number of movies for each genre.
5. **GenreRatings** - A view that calculates the average movie rating for each genre.
6. **Actors and Relationships** - SQL queries to create tables for actors, link them to movies, and insert actor data.
7. **MoviesDoneByActor** - A view that lists actors and how many movies they've been involved in.

## Prerequisites
- MySQL Workbench or any MySQL-compatible tool
- Access to a MySQL server for running the queries

