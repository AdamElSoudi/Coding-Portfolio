import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;

/**
 * A command line user interface for a movie database.
 */
public class MovieDatabaseUI {
    MovieDatabaseLogic movieDatabaseLogic = new MovieDatabaseLogic();


    private Scanner _scanner;

    /**
     * Construct a MovieDatabaseUI.
     */
    public MovieDatabaseUI() {

    }

    /**
     * Start the movie database UI.
     */
    public void startUI() throws IOException {
        _scanner = new Scanner(System.in);
        int input;
        boolean quit = false;

        System.out.println("** MOVIE DATABASE **");

        while (!quit) {
            input = getNumberInput(_scanner, 1, 4, getMainMenu());

            switch (input) {
                case 1:
                    searchTitel();
                    break;
                case 2:
                    searchReviewScore();
                    break;
                case 3:
                    addMovie();
                    break;
                case 4:
                    quit = true;
            }
        }
        //Close scanner to free resources
        _scanner.close();
    }

    /**
     * Get input and translate it to a valid number.
     *
     * @param scanner the Scanner we use to get input
     * @param min     the lowest correct number
     * @param max     the highest correct number
     * @param message message to user
     * @return the chosen menu number
     */
    private int getNumberInput(Scanner scanner, int min, int max, String message) {
        int input = -1;

        while (input < 0) {
            System.out.println(message);
            try {
                input = Integer.parseInt(scanner.nextLine().trim());
            } catch (NumberFormatException nfe) {
                input = -1;
            }
            if (input < min || input > max) {
                System.out.println("Invalid value");
                input = -1;
            }
        }
        return input;
    }

    /**
     * Get search string from user, search title in the movie
     * database and present the search result.
     */
    private void searchTitel() throws IOException {
        System.out.print("Enter key word: ");
        String title = _scanner.nextLine().trim();

        //TODO: Add call to search movie database based on input
        ArrayList<Integer> ratings = movieDatabaseLogic.getReview();
        ArrayList<String> movieTitles = movieDatabaseLogic.getMovies();
        movieDatabaseLogic.storage();
        ArrayList<Integer> movieResult = movieDatabaseLogic.searchMovieDB(title);


        for (int i = 0; i < movieResult.size(); i++){

            //TODO: Present results to user
            System.out.println("Title: " + movieTitles.get(movieResult.get(i)) + " Review Score " + ratings.get(movieResult.get(i)) + "/5");

        }
    }

    /**
     * Get search string from user, search review score in the movie
     * database and present the search result.
     */
    private void searchReviewScore() throws FileNotFoundException {
        int review = getNumberInput(_scanner, 1, 5, "Enter minumum review score (1 - 5): ");

        //TODO: Add call to search movie database based on input
        ArrayList<Integer> ratings = movieDatabaseLogic.getReview();
        ArrayList<String> movieTitles = movieDatabaseLogic.getMovies();
        movieDatabaseLogic.storage();
        ArrayList<Integer> ratingResult = movieDatabaseLogic.searchRating(review);


        for (int i = 0; i < ratingResult.size(); i++){

            //TODO: Present results to user
            System.out.println("Title: " + movieTitles.get(ratingResult.get(i)) + " Review Score " + ratings.get(ratingResult.get(i)) + "/5");

        }
    }


    /**
     * Get information from user on the new movie and add
     * it to the database.
     */
    private void addMovie() {
        System.out.print("Title: ");
        String title = _scanner.nextLine().trim();
        int reviewScore = getNumberInput(_scanner, 1, 5, "Review score (1 - 5): ");

        //TODO: Add call to add movie into database
        movieDatabaseLogic.movieAdd(title, reviewScore);


    }

    /**
     * Return the main menu text.
     *
     * @return the main menu text
     */
    private String getMainMenu() {
        return "-------------------\n" +
                "1. Search title\n" +
                "2. Search review score\n" +
                "3. Add movie\n" +
                "-------------------\n" +
                "4. Close program";
    }
}