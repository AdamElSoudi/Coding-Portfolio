import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;


public class MovieDatabaseLogic {

    /**
     * Here I created my array lists which take the contents of my files, I also created a boolean to help stop
     * my array lists from increasing in size for each input from the user.
     */
    private ArrayList<String> movies = new ArrayList<String>();
    private ArrayList<Integer> rating = new ArrayList<Integer>();
    private boolean storageExicuted = false;

    /**
     * @throws FileNotFoundException
     */
    public void storage() throws FileNotFoundException {

        /**
         * Here I firstly selected my file with movie titles. I made my file a scanner and then while my file
         * still had rows, each line becomes a string I called data which I then add to my movies array list.
         * I do the same again but with the ratings and add tem to my ratings array list.
         */
        if (!storageExicuted) {
            File movie = new File("src/Movies");
            Scanner movieTitle = new Scanner(movie);
            while (movieTitle.hasNextLine()) {
                String data = movieTitle.nextLine();
                movies.add(data);
            }

            File score = new File("src/Review");
            Scanner assessment = new Scanner(score);
            while (assessment.hasNextLine()) {
                int valuation = (assessment.nextInt());
                rating.add(valuation);
            }
            storageExicuted = true;
        }
    }

    /**
     * @param title is the keyword used by the user to search for movies in the database.
     * @throws FileNotFoundException
     */
    public ArrayList<Integer> searchMovieDB(String title) throws FileNotFoundException {
        ArrayList<Integer> movieResult = new ArrayList<Integer>();

        /**
         * Here I used a foorloop to go through my movies array list. I then checked if each movie
         * contained the users input and if it did, I printed out those movies.
         */
        for (int i = 0; i < movies.size(); i++) {
            if (movies.get(i).toUpperCase().contains(title.toUpperCase())) {
                movieResult.add(i);

            }
        }
        return movieResult;
    }

    /**
     * @param review is the number chosen by the user between 1 & 5 that searches for movies.
     * @throws FileNotFoundException
     */
    public ArrayList<Integer> searchRating(int review) throws FileNotFoundException {
        ArrayList<Integer> ratingResult = new ArrayList<Integer>();
        /**
         * Here I did the same thing except for the review score of each movie. Then I checked if
         * the users input was lower or equal to that index position in my arraylist so I could
         * show the movies with an equal or higher review score.
         */
        for (int i = 0; i < rating.size(); i++) {
            if (review <= rating.get(i)) {
                ratingResult.add(i);


            }
        }
        return ratingResult;
    }

    /**
     * @param title       is the title of the movie the user is adding to the database.
     * @param reviewScore is the review score of the movie the user is adding to the database.
     */
    public void movieAdd(String title, int reviewScore) {

        /**
         * These parameters allow for the users input for both movie title and review score from the UI
         * to be added to my array lists.
         */
        movies.add(title);
        rating.add(reviewScore);
    }

    public ArrayList<Integer> getReview() {
        return rating;
    }
    public ArrayList<String> getMovies(){
        return movies;
    }
}