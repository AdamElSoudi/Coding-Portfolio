# Lab5 - Movie Database Program

This Java program allows users to interact with a movie database. It supports searching movies by title or review score, as well as adding new movies with their review scores. The database is powered by two files:
- **Movies** – Contains a list of movie titles.
- **Review** – Contains review scores for the movies, with each score corresponding to a movie title in the **Movies** file.

### Features
- **Search by Title**: Users can search for movies by typing a keyword. The program will display all movies that contain the keyword, along with their review scores.
- **Search by Review Score**: Users can search for movies with a review score greater than or equal to the number they specify (1–5).
- **Add a Movie**: Users can add a new movie title and its review score to the database.
- **Persistent Storage**: The movie titles and review scores are read from two external files, **Movies** and **Review**.

### Program Structure
1. **MovieDatabaseLogic.java**: Handles the core logic for storing and searching movie data. It uses `ArrayList` to store movie titles and ratings and provides methods for adding, searching, and retrieving data.
2. **MovieDatabaseUI.java**: Provides the user interface through the command line. Users can interact with the program to search for movies or add new ones.
3. **MovieDatabaseMain.java**: The entry point for the program that initializes and starts the movie database UI.

### How It Works
1. When the program starts, the **MovieDatabaseUI** presents a menu with options:
   - **Search by title**: Allows the user to search movies by entering a keyword.
   - **Search by review score**: Allows the user to search for movies with a rating greater than or equal to a specified score.
   - **Add a new movie**: Allows the user to add a new movie title and its review score.
2. The **MovieDatabaseLogic** class loads the data from the **Movies** and **Review** files, stores them in memory, and provides methods for searching and adding movies.
3. After entering the database, the user can add a new movie, search by title, or search by rating, and the results will be displayed.

### File Structure
- **`MovieDatabaseLogic.java`**: Contains the logic for storing movie titles, ratings, and searching the database.
- **`MovieDatabaseMain.java`**: The main class to start the program.
- **`MovieDatabaseUI.java`**: The user interface class that handles user interactions through the command line.
- **`Movies`**: A text file containing the list of movie titles.
- **`Review`**: A text file containing the review scores for each movie, where each score corresponds to the title in the **Movies** file.

---
**Note:** The program could be improved by adding validation for duplicate movies and enhancing user interaction for a better experience.
