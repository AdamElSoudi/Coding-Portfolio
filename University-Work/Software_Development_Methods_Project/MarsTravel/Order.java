package MarsTravel;

import java.time.LocalDate;

/**
 * Class for temporarily saving choices made in booking process.
 */
public class Order {
    private static int cabinChoiceTo = 0;
    private static int foodBundleChoiceTo = 0;
    private static int movieToMars = 0;
    private static int concertToMars = 0;
    private static int theaterToMars = 0;

    private static int hotelOnMars = 0;
    private static LocalDate departureTo;
    private static LocalDate departureFrom;

    private static int cabinChoiceFrom = 0;
    private static int foodBundleChoiceFrom = 0;
    private static int movieFromMars = 0;
    private static int concertFromMars = 0;
    private static int theaterFromMars = 0;


    public static LocalDate getDepartureTo() { return departureTo;}
    public static void setDepartureTo(LocalDate date) { departureTo = date;}

    public static LocalDate getDepartureFrom() {
        return departureFrom;
    }
    public static void setDepartureFrom(LocalDate departureFrom) {
        Order.departureFrom = departureFrom;
    }

    public static int getCabinChoiceTo() {
        return cabinChoiceTo;
    }
    public static void setCabinChoiceTo(int cabin) {
        cabinChoiceTo = cabin;
    }

    public static int getFoodBundleChoiceTo() {
        return foodBundleChoiceTo;
    }
    public static void setFoodBundleChoiceTo(int foodBundle) {
        foodBundleChoiceTo = foodBundle;
    }

    public static int getMovieToMars() {
        return movieToMars;
    }
    public static void setMovieToMars(int movie) {
        movieToMars = movie;
    }

    public static int getConcertToMars() {
        return concertToMars;
    }
    public static void setConcertToMars(int concert) {
        concertToMars = concert;
    }

    public static int getTheaterToMars() {
        return theaterToMars;
    }
    public static void setTheaterToMars(int theatre) {theaterToMars = theatre; }

    public static int getHotelOnMars() {return hotelOnMars; }
    public static void setHotelOnMars(int hotelOnMars) {Order.hotelOnMars = hotelOnMars; }

    public static int getCabinChoiceFrom() { return cabinChoiceFrom; }
    public static void setCabinChoiceFrom(int cabinChoiceFrom) { Order.cabinChoiceFrom = cabinChoiceFrom; }

    public static int getFoodBundleChoiceFrom() { return foodBundleChoiceFrom; }
    public static void setFoodBundleChoiceFrom(int foodBundleChoiceFrom) { Order.foodBundleChoiceFrom = foodBundleChoiceFrom; }

    public static int getMovieFromMars() { return movieFromMars; }
    public static void setMovieFromMars(int movieFromMars) { Order.movieFromMars = movieFromMars; }

    public static int getConcertFromMars() { return concertFromMars; }
    public static void setConcertFromMars(int concertFromMars) { Order.concertFromMars = concertFromMars; }

    public static int getTheaterFromMars() { return theaterFromMars; }
    public static void setTheaterFromMars(int theaterFromMars) { Order.theaterFromMars = theaterFromMars; }

    /**
     * Builds string for using in call to database
     */
    public static void saveToDB(){
        String booking =
                "call save_booking(1, 2, " + cabinChoiceTo + ", " + foodBundleChoiceTo + ", " + movieToMars + ", "+ concertToMars + ", "+ theaterToMars + ", " + cabinChoiceFrom + ", " + foodBundleChoiceFrom + ", " + movieFromMars + ", "+ concertFromMars + ", "+ theaterFromMars +");";
        DatabaseConnect.databaseConnect(booking);
        String hotelbooking = "call save_hotel_booking("+ hotelOnMars + ", ' " + departureTo.plusMonths(6) +"', '"+ departureFrom +"')";
        DatabaseConnect.databaseConnect(hotelbooking);
    }

    /**
     * resets Order for starting a new booking
     */
    public static void resetOrder() {
        cabinChoiceTo = 0;
        foodBundleChoiceTo = 0;
        movieToMars = 0;
        concertToMars = 0;
        theaterToMars = 0;

        hotelOnMars = 0;
        departureTo = null;
        departureFrom = null;

        cabinChoiceFrom = 0;
        foodBundleChoiceFrom = 0;
        movieFromMars = 0;
        concertFromMars = 0;
        theaterFromMars = 0;
    }
}