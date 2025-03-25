This folder contains some Java projects completed during university coursework.  

# Lab3 - Integer Statistics Program

This Java program prompts the user to enter a specified number of integers and then calculates:  
- The **average value** of the entered numbers.  
- The **count of unique integers** (numbers that appear only once).  
- Input validation ensures only integers are accepted, preventing errors from invalid inputs.  

### Features
- Uses **ArrayLists** for dynamic storage of integers.
- Implements **exception handling** to manage invalid user input.
- Utilizes **nested loops** to determine unique values.

### How It Works
1. The user specifies how many integers they want to enter.
2. The program collects valid integers, rejecting invalid inputs.
3. It calculates and displays:
   - The **average** of the entered numbers.
   - The number of **unique integers** in the input.

---
**Note:** The program can be improved by optimizing the uniqueness check and enhancing error messages.

---

# Lab4 - Swedish to English Translation Quiz

This Java program is a simple **Swedish to English translation quiz** where users translate words and receive feedback on their answers.

## Features
- **Word Bank:** Contains 10 Swedish words and their correct English translations.
- **Case-Insensitive Checking:** User input is compared to the correct answer regardless of case.
- **Partial Credit:** If a user's answer is more than **50% correct**, they receive an "Almost correct!" message.
- **Exit Option:** Users can type **'Q'** to quit at any time, displaying their final score.

## How It Works
1. The user is prompted with a Swedish word and must type the English translation.
2. The program checks the answer:
   - **Correct answers** increase the score.
   - **Incorrect answers** display the correct word.
   - **Partial matches** receive an "Almost correct!" message.
3. If the user enters **'Q'**, the game ends and displays their total score.

## Files
- **`Lab4Code.java`**: Contains the main quiz logic.
- **`Lab4.java`**: Runs the program by calling `Lab4Code`.

---
**Note:** The program could be improved by expanding the word bank and refining the similarity check.

---

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
