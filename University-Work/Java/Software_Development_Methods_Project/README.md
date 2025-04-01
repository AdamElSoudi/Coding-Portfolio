# MarsTravel – Software Development Methods Project

## 🪐 Overview

**MarsTravel** is a Java-based desktop application developed as a group project for the **Software Development Methods** course. The system simulates an interplanetary travel booking service, allowing users to plan and purchase trips to Mars—including rocket tickets, hotel accommodations, and bundled travel packages.

This project emphasized agile software development through sprint-based iterations, team collaboration, and modular system design.

---

## 🚀 Key Features

- **Rocket Ticket Booking**  
  Users can view and purchase tickets for space travel to Mars.

- **Hotel Booking**  
  Browse available accommodations on Mars and complete hotel reservations.

- **Travel Packages**  
  Bundle hotel stays, rocket tickets, and exclusive tours into all-in-one travel packages.

- **User-Friendly Interface**  
  Built using **JavaFX** for a responsive and interactive booking experience.

- **Database Integration**  
  Bookings and available services are stored and managed using **SQL** and a backend database.

- **Modular Structure & Sprint-Based Workflow**  
  Developed in sprints, following agile methodology and assigning team members to focus areas (UI, logic, database, etc.).

---

## 🛠️ Technologies Used

- **Java** – Core language for backend logic and application structure  
- **JavaFX** – GUI framework for a rich user interface  
- **SQL** – Database integration to manage bookings and services  
- **Scene Builder** – Used to design and organize FXML-based UI components

---

## ⚠️ Database Setup Required

> ❗ **Important:** The application **requires a database** to be set up before it can run correctly.

- The SQL file `mtdone.sql` is included in the project repository and contains all necessary table definitions, data, and stored procedures.  
  👉 [View mtdone.sql on GitHub](https://github.com/AdamElSoudi/Coding-Portfolio/blob/main/University-Work/Java/Software_Development_Methods_Project/mtdone.sql)


  ### To set up the database:

1. Open your MySQL client (e.g., MySQL Workbench, phpMyAdmin, or terminal).
2. Create a new database (recommended name: `mt`).
3. Import the SQL dump file:
```sql
SOURCE /path/to/mtdone.sql;
```
> Replace `/path/to/mtdone.sql` with the actual path to the `mtdone.sql` file on your machine.


_Or, in **MySQL Workbench**: `File → Open SQL Script → Run`._

Make sure your `DatabaseConnect.java` file has the correct database name (`mt`) and login credentials for your local MySQL server:
- **Database name:** `mt`  
- **Host:** `localhost`  
- **Username and password:** your MySQL credentials

---

## 👥 Team Collaboration

MarsTravel was developed by a team of **5 members**, each contributing to different components of the system, such as:

- Database schema and query development
- Controller logic and Java backend
- JavaFX front-end layout and UI behavior
- System integration and testing

Agile practices were used throughout the project, with tasks divided into **sprints** and regular evaluations for feedback and improvement.

---

## 📂 Project Structure Highlights

- `controllers/` – JavaFX controllers for booking flows (hotels, tickets, packages)  
- `models/` – Logic and data representations (e.g., `Booking`, `User`)  
- `database/` – SQL access layer via `DatabaseConnect.java`  
- `resources/fxml/` – GUI layout files built with Scene Builder

---

## 📌 Note

This project was created strictly for educational purposes as part of a university assignment. While the UI and system design aim to simulate a real-world travel platform, the data and booking functionality are fictional and not intended for commercial use. In other words, you cannot actually book a trip to Mars.
