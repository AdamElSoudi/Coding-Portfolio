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
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;

import java.io.IOException;

/**
 * Scene for information and booking of event tickets on journey from Mars
 */
public class FromMars_EventTickets_Controller {
    final int INITIAL_VALUE = 0;

    @FXML
    private Button btnCancel;

    @FXML
    private Button btnBack;

    @FXML
    private Button btnSave;

    @FXML
    private AnchorPane eventTicketsFromMars;

    @FXML
    private Label lblEventTicketsFromMars;

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
    private Spinner<Integer> movieTicketsFromMars; //0-6

    @FXML
    private Spinner<Integer> concertTicketsFromMars; //0-3

    @FXML
    private Spinner<Integer> theaterTicketsFromMars; //0-3

    //Sets spinners to display value 0 as default and sets range of possible choices
    private SpinnerValueFactory<Integer> spinMovieTicketsFromMars = new SpinnerValueFactory.IntegerSpinnerValueFactory(0, 6, INITIAL_VALUE);
    private SpinnerValueFactory<Integer> spinConcertTicketsFromMars = new SpinnerValueFactory.IntegerSpinnerValueFactory(0, 3, INITIAL_VALUE);
    private SpinnerValueFactory<Integer> spinTheaterTicketsFromMars = new SpinnerValueFactory.IntegerSpinnerValueFactory(0, 3, INITIAL_VALUE);


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
        if (Order.getMovieFromMars() != 0) {
            spinMovieTicketsFromMars.setValue(Order.getMovieFromMars());
        }
        this.movieTicketsFromMars.setValueFactory(spinMovieTicketsFromMars);

        if (Order.getConcertFromMars() != 0) {
            spinConcertTicketsFromMars.setValue(Order.getConcertFromMars());
        }
        this.concertTicketsFromMars.setValueFactory(spinConcertTicketsFromMars);

        if (Order.getTheaterFromMars() != 0) {
            spinTheaterTicketsFromMars.setValue(Order.getTheaterFromMars());
        }
        this.theaterTicketsFromMars.setValueFactory(spinTheaterTicketsFromMars);
    }

    /**
     * Saves choice of tickets
     * Saves Order to database
     * Opens TravellerInformation scene
     * @param event user pressed button to go to scene for traveller information
     */
    @FXML
    void btnSave(ActionEvent event) throws IOException{
        //Saves choice to Order
        setAllEventTickets();

        //Opens scene for traveller information
        FXMLLoader loader = new FXMLLoader(getClass().getResource("TravellerInformation.fxml"));
        Parent parent = loader.load();
        Scene TravellerInformationScene = new Scene(parent);
        Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
        window.setScene(TravellerInformationScene);
        window.show();
    }

    /**
     * Opens previous scene in booking process
     * @param event user pressed button for going backwards in booking process
     * @throws IOException
     */
    @FXML
    public void openFoodBundleFromMarsScene(ActionEvent event) throws IOException {
        setAllEventTickets();
        FXMLLoader loader = new FXMLLoader(getClass().getResource("FromMars_FoodBundle.fxml"));
        Parent parent = loader.load();
        Scene scene = new Scene(parent);
        Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
        window.setScene(scene);
        window.show();
    }

    /**
     * Saves choice to Order
     */
    private void setAllEventTickets () {
        Order.setMovieFromMars(movieTicketsFromMars.getValue());
        Order.setTheaterFromMars(theaterTicketsFromMars.getValue());
        Order.setConcertFromMars(concertTicketsFromMars.getValue());
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
