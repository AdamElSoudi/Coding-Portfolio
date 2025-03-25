package MarsTravel;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextArea;
import javafx.stage.Stage;

import java.io.IOException;

/**
 * Scene for a summary of all choices made through booking process.
 */
public class BookingOverview_Controller {

    @FXML
    private Button btnBack;

    @FXML
    private Button btnCancel;

    @FXML
    private Button btnSave;

    @FXML
    private Label earthArrivalDate;

    @FXML
    private Label earthDepDate;

    @FXML
    private Label lblAddress;

    @FXML
    private Label lblAddressGiven;

    @FXML
    private Label lblBookingSummary;

    @FXML
    private Label lblCardAmount;

    @FXML
    private Label lblChronicPain;

    @FXML
    private Label lblChronicPainYesNo;

    @FXML
    private Label lblEmail;

    @FXML
    private Label lblEmailGiven;

    @FXML
    private Label lblEventTickets;

    @FXML
    private Label lblFirstname;

    @FXML
    private Label lblFirstnameGiven;

    @FXML
    private Label lblFromCabin;
    @FXML
    private Label lblFromCabinChoice;

    @FXML
    private Label lblFromConcertTicket;
    @FXML
    private Label lblFromConcertTicketChoice;

    @FXML
    private Label lblFromFoodBundle;
    @FXML
    private Label lblFromFoodBundleChoice;

    @FXML
    private Label lblFromMars;

    @FXML
    private Label lblFromMovieTicket;

    @FXML
    private Label lblFromMovieTicketsChoice;

    @FXML
    private Label lblSumma;
    @FXML
    private Label lblFromTheaterTicket;

    @FXML
    private Label lblFromTheaterTicketsChoice;

    @FXML
    private Label lblHealthInsurance;
    @FXML
    private Label lblHealthInsuranceYesNo;

    @FXML
    private Label lblHealthy;

    @FXML
    private Label lblHealthyYesNo;

    @FXML
    private Label lblLastname;

    @FXML
    private Label lblLastnameGiven;

    @FXML
    private Label lblMedicine;

    @FXML
    private Label lblMedicineYesNo;

    @FXML
    private Label lblOnHotelChoice;

    @FXML
    private Label lblOnMars;

    @FXML
    private Label lblPersonalNumber;

    @FXML
    private Label lblPersonalNumberGiven;

    @FXML
    private Label lblToCabin;

    @FXML
    private Label lblToCabinChoice;

    @FXML
    private Label lblToConcertTicket;

    @FXML
    private Label lblToConcertTicketChoice;

    @FXML
    private Label lblToFoodBundle;

    @FXML
    private Label lblToFoodBundleChoice;

    @FXML
    private Label lblToMars;

    @FXML
    private Label lblToMovieTickets;

    @FXML
    private Label lblToMovieTicketsChoice;

    @FXML
    private Label lblToTheaterTicket;

    @FXML
    private Label lblToTheaterTicketsChoice;

    @FXML
    private Label lblTravellerInformation;

    @FXML
    private Label marsArrivalDate;

    @FXML
    private Label marsDepartureDate;

    @FXML
    private TextArea txtChronicPain;

    @FXML
    private TextArea txtMedicine;

    /**
     * Starts scene.
     */
    @FXML
    public void initialize(){
        setTravellerInformation();
        setOrder();
        setDates();
        setTotSum();
    }

    /**
     * Gets dates and puts them in the booking overview.
     */
    public void setDates () {
        earthDepDate.setText(Order.getDepartureTo().toString());
        marsArrivalDate.setText(Order.getDepartureTo().plusMonths(6).toString());
        marsDepartureDate.setText(Order.getDepartureFrom().toString());
        earthArrivalDate.setText(Order.getDepartureFrom().plusMonths(6).toString());
    }

    /**
     * Gets choices from Order class and puts the into the booking overview scene.
     * Used to display options for travel.
     */
    public void setOrder(){
        lblToCabinChoice.setText(DatabaseConnect.databaseQuery("SELECT cabin_type FROM cabin_types WHERE cabin_type_ID = "+ Order.getCabinChoiceTo() +"", "cabin_type"));
        lblFromCabinChoice.setText(DatabaseConnect.databaseQuery("SELECT cabin_type FROM cabin_types WHERE cabin_type_ID = "+ Order.getCabinChoiceFrom() +"", "cabin_type"));

        if (Order.getCabinChoiceTo() == 1) {
            lblToFoodBundleChoice.setText("");
        } else {
            lblToFoodBundleChoice.setText(DatabaseConnect.databaseQuery("SELECT bundle_name FROM food_bundle WHERE bundle_ID = " + Order.getFoodBundleChoiceTo() + "", "bundle_name"));
        }
        if(Order.getCabinChoiceFrom() == 1) {
            lblFromFoodBundleChoice.setText("");
        } else {
            lblFromFoodBundleChoice.setText(DatabaseConnect.databaseQuery("SELECT bundle_name FROM food_bundle WHERE bundle_ID = " + Order.getFoodBundleChoiceFrom() + "", "bundle_name"));
        }

        if (Order.getCabinChoiceTo() == 1) {
            lblToMovieTicketsChoice.setText("0");
            lblToConcertTicketChoice.setText("0");
            lblToTheaterTicketsChoice.setText("0");
        } else {
            lblToMovieTicketsChoice.setText(Integer.toString(Order.getMovieToMars()));
            lblToConcertTicketChoice.setText(Integer.toString(Order.getConcertToMars()));
            lblToTheaterTicketsChoice.setText(Integer.toString(Order.getTheaterToMars()));
        }
        if(Order.getCabinChoiceFrom() == 1) {
            lblFromMovieTicketsChoice.setText("0");
            lblFromConcertTicketChoice.setText("0");
            lblFromTheaterTicketsChoice.setText("0");
        } else {
            lblFromMovieTicketsChoice.setText(Integer.toString(Order.getMovieFromMars()));
            lblFromConcertTicketChoice.setText(Integer.toString(Order.getConcertFromMars()));
            lblFromTheaterTicketsChoice.setText(Integer.toString(Order.getTheaterFromMars()));
        }

        lblOnHotelChoice.setText(DatabaseConnect.databaseQuery("SELECT hotel_namn FROM hotel WHERE hotel_ID = "+ Order.getHotelOnMars(), "hotel_namn") + " \n" + DatabaseConnect.databaseQuery("SELECT room_type FROM hotel WHERE hotel_ID = "+ Order.getHotelOnMars() +"", "room_type"));

    }

    /**
     * Gets choices from Traveller to labels and  text fields.
     * Used for display of input
     */
    public void setTravellerInformation(){
        lblPersonalNumberGiven.setText(Traveller.getPersonalNumber());
        lblFirstnameGiven.setText(Traveller.getFirstName());
        lblLastnameGiven.setText(Traveller.getLastName());
        lblEmailGiven.setText(Traveller.getEmail());
        lblAddressGiven.setText(Traveller.getAddress());
        lblCardAmount.setText(Traveller.getCreditCard() + " kr");

        if (Traveller.getHealthy() == 1) {
            lblHealthyYesNo.setText("Ja");
        } else if (Traveller.getHealthy() == 2) {
            lblHealthyYesNo.setText("Nej");
        }

        if (Traveller.getChronicPain() == 1) {
                lblChronicPainYesNo.setText("Ja");
            } else if (Traveller.getChronicPain() == 2) {
                lblChronicPainYesNo.setText("Nej");
            }
        txtChronicPain.setText(Traveller.getChronicPainText());

        if (Traveller.getMedicine() == 1) {
            lblMedicineYesNo.setText("Ja");
        } else if (Traveller.getMedicine() == 2) {
            lblMedicineYesNo.setText("Nej");
        }
        txtMedicine.setText(Traveller.getMedicineText());

        if (Traveller.getHealthInsurance() == 1) {
            lblHealthInsuranceYesNo.setText("Ja");
        } else if (Traveller.getHealthInsurance() == 2) {
            lblHealthInsuranceYesNo.setText("Nej");
        }
    }

    /**
     * Opens scene for inputting traveller information.
     * @param event user pressed button for going back to scene for inputting traveller information
     * @throws IOException
     */
    @FXML
    void btnBack(ActionEvent event) throws IOException {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("TravellerInformation.fxml"));
        Parent parent = loader.load();
        Scene scene = new Scene(parent);
        Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
        window.setScene(scene);
        window.show();
    }

    /**
     * Ends booking process, saves to database, opens date selection scene for new booking process.
     * @param event user pressed button for saving booking
     * @throws IOException
     */
    @FXML
    void btnSave(ActionEvent event) throws IOException {

       //Save Order to database
        Traveller.saveToDB();
        Order.saveToDB();
        Traveller.saveToDB2();

        Order.resetOrder();
        Traveller.resetTraveller();

        FXMLLoader loader = new FXMLLoader(getClass().getResource("ToMars_Departure.fxml"));
        Parent parent = loader.load();
        Scene scene = new Scene(parent);
        Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
        window.setScene(scene);
        window.show();
    }

    @FXML
    public void setTotSum() {
        lblSumma.setText(TravellerInformation_Controller.totalSum() + " kr");
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
