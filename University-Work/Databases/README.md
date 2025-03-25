# Database Project: Monster Collector Mobile Game

## Project Overview
This project involves building the database solution for a mobile application where players collect various figures (or monsters). 
The game starts with 100 different types of monsters, all belonging to the same region (with potential expansions where new monsters will belong
to different regions). Each monster type has a name and a description.

Players can capture and own one or more monsters of each type. Each player has a unique username, phone number, and email address.
Players can also be friends with other players in the game. There are three teams in the game: Cyan, Magenta, and Yellow, and each player
belongs to one of these teams. The game also includes Gyms, where players can assign one of their monsters to guard a Gym.
Each Gym has a name and is associated with GPS coordinates.

Players earn experience points (XP) and level up based on their XP. 
The project required the implementation of various SQL queries to retrieve and manipulate data for the mobile application.

## Project Requirements

### Entity Overview:
- **Monsters**: 100 types of monsters with names, descriptions, and region affiliations.
- **Players**: Each player has a unique username, phone number, email, and team affiliation (Cyan, Magenta, or Yellow).
- **Gyms**: Players can assign their monsters to guard Gyms, each associated with a name and GPS coordinates.
- **XP and Levels**: Players earn XP and level up according to their experience:
  - Level 1: 0-1000 XP
  - Level 2: 1001-3000 XP
  - Level 3: 3001-6000 XP
  - Level 4: 6001-10000 XP
  - Level 5: More than 10000 XP

### SQL Queries Implemented:
1. **List player names and the number of monster types they have captured.**
2. **Count the number of players in each team.**
3. **List all players with their levels based on XP.**
4. **List all monster types and the number of each monster captured by players.**
5. **List the player with the most friends in each team.**
6. **List the monster types and the number of each type captured by the player who has captured the most monsters.**
7. **List the three monster types with the least number of captures.**
8. **Calculate the average number of monsters captured by each player per type.**
9. **List the Gyms guarded by a player's friends, including the monster guarding the Gym and the friend's name.**
10. **List phone numbers of players who have monsters guarding a Gym near a shopping mall, to offer businesses special offers via SMS.**

### Technologies Used:
- **SQL**: Used to design and implement the database schema and queries.
- **Database**: Relational database management system (RDBMS) to store player, monster, Gym, and other relevant data.

The goal of this project was to demonstrate database design and query skills while working in a team environment.
We focused on applying concepts from software development methods and database design principles to ensure the system
is both efficient and scalable.
