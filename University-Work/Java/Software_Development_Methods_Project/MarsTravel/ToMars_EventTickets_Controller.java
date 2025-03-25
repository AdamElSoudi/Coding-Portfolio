package MarsTravel;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.Spinner;
import javafx.scene.control.SpinnerValueFactory;
import javafx.scene.input.KeyEvent;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;

import java.io.IOException;


/**
 * Scene for information and booking of event tickets on journey to Mars
 */
public class ToMars_EventTickets_Controller {
    final int INITIAL_VALUE = 0;

    @FXML
    private Button btnCancel;

    @FXML
    private Button btnBack;

    @FXML
    private Button btnSave;

    @FXML
    private AnchorPane eventTicketsToMars;

    @FXML
    private Label lblEventTicketsToMars;

    @FXML
    private Label lblOpt1;

    @FXML
    private Label lblOpt1Descript;

    @FXML
    private Label lblOpt2;

    @FXML
    private Label lblOpt2Descript;

    @FXML
    private Label lblOpt3;

    @FXML
    private Label lblOpt3Descript;

    @FXML
    private Spinner<Integer> movieTicketsToMars; //0-6

    @FXML
    private Spinner<Integer> consertTicketsToMars; //0-3

    @FXML
    private Spinner<Integer> theaterTicketsToMars; //0-3

    //Sets spinners to display value 0 as default and sets range of possible choices
    private SpinnerValueFactory<Integer> spinMovieTicketsToMars = new SpinnerValueFactory.IntegerSpinnerValueFactory(0, 6, INITIAL_VALUE);
    private SpinnerValueFactory<Integer> spinConsertTicketsToMars = new SpinnerValueFactory.IntegerSpinnerValueFactory(0, 3, INITIAL_VALUE);
    private SpinnerValueFactory<Integer> spinTheaterTicketsToMars = new SpinnerValueFactory.IntegerSpinnerValueFactory(0, 3, INITIAL_VALUE);


    /**
     * Starts scene
     */
    @FXML
    private void initialize() {
        display();
        setStartSpinners();
    }

    /**
     * Calls to database to get names and descriptions of event options for display on labels
     */
    private void display() {
        lblOpt1.setText(DatabaseConnect.databaseQuery("select name from event_types where event_types_ID = 2", "name"));
        lblOpt1Descript.setText(DatabaseConnect.databaseQuery("select event_description from event_types where event_types_ID = 2", "event_description") +
                "\n" + "Pris: " + DatabaseConnect.databaseQuery("select price from event_types where event_types_ID = 2", "price") + "kr/biljett");
        lblOpt2.setText(DatabaseConnect.databaseQuery("select name from event_types where event_types_ID = 1", "name"));
        lblOpt2Descript.setText(DatabaseConnect.databaseQuery("select event_description from event_types where event_types_ID = 1", "event_description") +
                "\n" + "Pris: " + DatabaseConnect.databaseQuery("select price from event_types where event_types_ID = 1", "price") + "kr/biljett");
        lblOpt3.setText(DatabaseConnect.databaseQuery("select name from event_types where event_types_ID = 3", "name"));
        lblOpt3Descript.setText(DatabaseConnect.databaseQuery("select event_description from event_types where event_types_ID = 3", "event_description") +
                "\n" + "Pris: " + DatabaseConnect.databaseQuery("select price from event_types where event_types_ID = 3", "price") + "kr/biljett");
    }

    /**
     * Gets choice from Order to spinners.
     * Used in case of going backwards in booking process.
     */
    private void setStartSpinners() {
        if (Order.getMovieToMars() != 0) {
            spinMovieTicketsToMars.setValue(Order.getMovieToMars());
        }
        this.movieTicketsToMars.setValueFactory(spinMovieTicketsToMars);

        if (Order.getConcertToMars() != 0) {
            spinConsertTicketsToMars.setValue(Order.getConcertToMars());
        }
        this.consertTicketsToMars.setValueFactory(spinConsertTicketsToMars);

        if (Order.getTheaterToMars() != 0) {
            spinTheaterTicketsToMars.setValue(Order.getTheaterToMars());
        }
        this.theaterTicketsToMars.setValueFactory(spinTheaterTicketsToMars);
    }



    /**
     * Saves choice of tickets
     * Opens next scene OnMars_Hotel
     * @param event user pressed button to save booking
     */
    @FXML
    public void openHotelOnMars(ActionEvent event) throws IOException{
        //Saves choice to Order
        setAllEventTickets();

        FXMLLoader loader = new FXMLLoader(getClass().getResource("OnMars_Hotel.fxml"));
        Parent parent = loader.load();
        Scene HotelOnMarsScene = new Scene(parent);
        Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
        window.setScene(HotelOnMarsScene);
        window.show();

    }

    @FXML
    void noOfConcertTicketsToMars(KeyEvent event) {
    }
    @FXML
    void noOfMovieTicketToMars(KeyEvent event) {
    }
    @FXML
    void noOfTheaterTicketsToMars(KeyEvent event) {
    }


    /**
     * Opens previous scene in booking process, ToMars_FoodBundle
     * @param event user pressed button for going backwards in booking process
     * @throws IOException
     */
    @FXML
    public void openFoodBundleToMarsScene(ActionEvent event) throws IOException {
        setAllEventTickets();
        FXMLLoader loader = new FXMLLoader(getClass().getResource("ToMars_FoodBundle.fxml"));
        Parent parent = loader.load();
        Scene scene = new Scene(parent);
        Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
        window.setScene(scene);
        window.show();
    }


    /**
     * Saves ticket choices to Order
     */
    private void setAllEventTickets () {
        Order.setMovieToMars(movieTicketsToMars.getValue());
        Order.setTheaterToMars(theaterTicketsToMars.getValue());
        Order.setConcertToMars(consertTicketsToMars.getValue());
    }


    /**
     * Cancels booking process and takes user back to date selection
     * @param event user pressed button for cancelling booking process
     * @throws IOException
     */
    @FXML
    void cancelBooking(ActionEvent event) throws IOException{
        Order.resetOrder();
        Traveller.resetTraveller();

        FXMLLoader loader = new FXMLLoader(getClass().getResource("ToMars_Departure.fxml"));
        Parent parent = loader.load();
        Scene scene = new Scene(parent);
        Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
        window.setScene(scene);
        window.show();
    }
}
