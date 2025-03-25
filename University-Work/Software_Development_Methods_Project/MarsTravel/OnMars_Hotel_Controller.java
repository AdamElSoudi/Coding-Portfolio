package MarsTravel;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.Label;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;

import java.io.IOException;
import java.time.LocalDate;

/**
 * Class for picking hotel option while on Mars.
 */
public class OnMars_Hotel_Controller {

    private LocalDate trip9 = LocalDate.of(2023, 8, 1);
    private LocalDate trip10 = LocalDate.of(2023, 9, 1);
    private LocalDate trip11 = LocalDate.of(2023, 10, 1);
    private LocalDate trip12 = LocalDate.of(2023, 11, 1);
    private LocalDate trip13 = LocalDate.of(2023, 12, 1);
    private LocalDate trip14 = LocalDate.of(2024, 1, 1);
    private LocalDate trip15 = LocalDate.of(2024, 2, 1);
    private LocalDate trip16 = LocalDate.of(2024, 3, 1);
    private LocalDate trip17 = LocalDate.of(2024, 4, 1);

    private LocalDate[] datesFrom = {trip9, trip10, trip11, trip12, trip13, trip14, trip15, trip16, trip17};

    @FXML
    private Button btnCancel;

    @FXML
    private AnchorPane HotelInfo;

    @FXML
    private Button btnBack;

    @FXML
    private Button btnHotelInfo;

    @FXML
    private Button btnSave;

    @FXML
    private Label lblHotel;

    @FXML
    private CheckBox opt1;

    @FXML
    private CheckBox opt2;

    @FXML
    private CheckBox opt3;

    @FXML
    private CheckBox opt4;

    @FXML
    private CheckBox opt5;

    @FXML
    private CheckBox opt6;

    @FXML
    private CheckBox opt7;

    @FXML
    private CheckBox opt8;

    @FXML
    private CheckBox opt9;

    @FXML
    private ChoiceBox<LocalDate> chDateChoice;

    @FXML
    private Label lblArrival;

    @FXML
    private Label lblArrivalDate;

    @FXML
    private Label lblDeparture;



    /**
     * Calls to database to get names of hotel options for display on buttons
     */
    private void display() {
        opt1.setText(DatabaseConnect.databaseQuery("SELECT hotel_namn FROM hotel WHERE hotel_ID = 1", "hotel_namn") + ", " + DatabaseConnect.databaseQuery("SELECT room_type FROM hotel WHERE hotel_ID = 1", "room_type"));
        opt2.setText(DatabaseConnect.databaseQuery("SELECT hotel_namn FROM hotel WHERE hotel_ID = 2", "hotel_namn") + ", " + DatabaseConnect.databaseQuery("SELECT room_type FROM hotel WHERE hotel_ID = 2", "room_type"));
        opt3.setText(DatabaseConnect.databaseQuery("SELECT hotel_namn FROM hotel WHERE hotel_ID = 3", "hotel_namn") + ", " + DatabaseConnect.databaseQuery("SELECT room_type FROM hotel WHERE hotel_ID = 3", "room_type"));
        opt4.setText(DatabaseConnect.databaseQuery("SELECT hotel_namn FROM hotel WHERE hotel_ID = 4", "hotel_namn") + ", " + DatabaseConnect.databaseQuery("SELECT room_type FROM hotel WHERE hotel_ID = 4", "room_type"));
        opt5.setText(DatabaseConnect.databaseQuery("SELECT hotel_namn FROM hotel WHERE hotel_ID = 5", "hotel_namn") + ", " + DatabaseConnect.databaseQuery("SELECT room_type FROM hotel WHERE hotel_ID = 5", "room_type"));
        opt6.setText(DatabaseConnect.databaseQuery("SELECT hotel_namn FROM hotel WHERE hotel_ID = 6", "hotel_namn") + ", " + DatabaseConnect.databaseQuery("SELECT room_type FROM hotel WHERE hotel_ID = 6", "room_type"));
        opt7.setText(DatabaseConnect.databaseQuery("SELECT hotel_namn FROM hotel WHERE hotel_ID = 7", "hotel_namn") + ", " + DatabaseConnect.databaseQuery("SELECT room_type FROM hotel WHERE hotel_ID = 7", "room_type"));
        opt8.setText(DatabaseConnect.databaseQuery("SELECT hotel_namn FROM hotel WHERE hotel_ID = 8", "hotel_namn") + ", " + DatabaseConnect.databaseQuery("SELECT room_type FROM hotel WHERE hotel_ID = 8", "room_type"));
        opt9.setText(DatabaseConnect.databaseQuery("SELECT hotel_namn FROM hotel WHERE hotel_ID = 9", "hotel_namn") + ", " + DatabaseConnect.databaseQuery("SELECT room_type FROM hotel WHERE hotel_ID = 9", "room_type"));

        lblArrivalDate.setText(Order.getDepartureTo().plusMonths(6).toString());
    }

    /**
     * Starts scene
     */
    @FXML
    private void initialize() {
        display();
        setStartCheckbox();
        setStartDateChoice();
    }

    /**
     * Checks the date selected for travel.
     * @throws IOException
     */
    @FXML
    public void checkSelectedDate() throws IOException {
        Order.setDepartureFrom(chDateChoice.getValue());
    }

    /**
     * Sets the first date possible to book a hotel and the duration traveller can stay.
     * Based on the date for travel selected.
     */
    private void setStartDateChoice() {

        ObservableList<LocalDate> datesFromAvailable = FXCollections.observableArrayList();

        for (LocalDate date : datesFrom) {
            if (date.isEqual(Order.getDepartureTo().plusMonths(7)) || date.isAfter(Order.getDepartureTo().plusMonths(7))) {
                datesFromAvailable.add(date);
            }
        }
        chDateChoice.setItems(datesFromAvailable);

        if (Order.getDepartureFrom() == null || Order.getDepartureFrom().isBefore(Order.getDepartureTo().plusMonths(7))) {
            chDateChoice.setValue(datesFromAvailable.get(0));
        } else {
            chDateChoice.setValue(Order.getDepartureFrom());
        }
    }


    /**
     * Gets choice from Order to checkboxes.
     * Used in case of going backwards in booking process.
     */
    private void setStartCheckbox() {
        if (Order.getHotelOnMars() == 0) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            opt6.setSelected(false);
            opt7.setSelected(false);
            opt8.setSelected(false);
        } else if (Order.getHotelOnMars() == 1) {
            opt1.setSelected(true);
        } else if (Order.getHotelOnMars() == 2) {
            opt2.setSelected(true);
        } else if (Order.getHotelOnMars() == 3) {
            opt3.setSelected(true);
        } else if (Order.getHotelOnMars() == 4) {
            opt4.setSelected(true);
        } else if (Order.getHotelOnMars() == 5) {
            opt5.setSelected(true);
        } else if (Order.getHotelOnMars() == 6) {
            opt6.setSelected(true);
        } else if (Order.getHotelOnMars() == 7) {
            opt7.setSelected(true);
        } else if (Order.getHotelOnMars() == 8) {
            opt8.setSelected(true);
        } else if (Order.getHotelOnMars() == 9) {
            opt9.setSelected(true);
        }
    }

    /**
     * Prohibits multiple choice.
     * Saves choice to Order.
     * @param event checkbox checked
     * @throws IOException
     */
    @FXML
    public void checkBoxSetSelectedHotel(ActionEvent event) throws IOException {

        if (event.getSource().equals(opt1)) {
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            opt6.setSelected(false);
            opt7.setSelected(false);
            opt8.setSelected(false);
            opt9.setSelected(false);
            Order.setHotelOnMars(1);

        } else if (event.getSource().equals(opt2)) {
            opt1.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            opt6.setSelected(false);
            opt7.setSelected(false);
            opt8.setSelected(false);
            opt9.setSelected(false);
            Order.setHotelOnMars(2);

        } else if (event.getSource().equals(opt3)) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            opt6.setSelected(false);
            opt7.setSelected(false);
            opt8.setSelected(false);
            opt9.setSelected(false);
            Order.setHotelOnMars(3);

        } else if (event.getSource().equals(opt4)) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt5.setSelected(false);
            opt6.setSelected(false);
            opt7.setSelected(false);
            opt8.setSelected(false);
            opt9.setSelected(false);
            Order.setHotelOnMars(4);

        } else if (event.getSource().equals(opt5)) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt6.setSelected(false);
            opt7.setSelected(false);
            opt8.setSelected(false);
            opt9.setSelected(false);
            Order.setHotelOnMars(5);

        } else if (event.getSource().equals(opt6)) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            opt7.setSelected(false);
            opt8.setSelected(false);
            opt9.setSelected(false);
            Order.setHotelOnMars(6);

        } else if (event.getSource().equals(opt7)) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            opt6.setSelected(false);
            opt8.setSelected(false);
            opt9.setSelected(false);
            Order.setHotelOnMars(7);

        } else if (event.getSource().equals(opt8)) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            opt6.setSelected(false);
            opt7.setSelected(false);
            opt9.setSelected(false);
            Order.setHotelOnMars(8);

        } else if (event.getSource().equals(opt9)) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            opt6.setSelected(false);
            opt7.setSelected(false);
            opt8.setSelected(false);
            Order.setHotelOnMars(9);
        }
    }

    /**
     * Controls that a checkbox is selected and else sets choice in Order to 0
     */
    private void checkCheckBoxSelected() {
        if (!(opt1.isSelected() || opt2.isSelected() || opt3.isSelected() || opt4.isSelected() || opt5.isSelected() ||
                opt6.isSelected() || opt7.isSelected() || opt8.isSelected() || opt9.isSelected())) {
            Order.setHotelOnMars(0);
        }
    }

    /**
     * Opens scene for hotel info
     *
     * @param event user pressed button for info about hotels
     * @throws IOException
     */
    @FXML
    public void openHotelInfoOnMarsScene(ActionEvent event) throws IOException {
        checkSelectedDate();
        checkCheckBoxSelected();

        FXMLLoader loader = new FXMLLoader(getClass().getResource("Info_Hotel.fxml"));
        Parent parent = loader.load();
        Scene hotelInfoScene = new Scene(parent);
        Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
        window.setScene(hotelInfoScene);
        window.show();
    }

    /**
     * Back button, sends to ToMars_Cabin scene if "Sömnkapsel" option is selected,
     * sends to ToMars_EventTickets scene if any other option is selected.
     * @param event user pressed button to move back in the booking process.
     * @throws IOException
     */
    @FXML
    public void OpenEventToMars(ActionEvent event) throws IOException {
        checkSelectedDate();
        checkCheckBoxSelected();

        if (Order.getCabinChoiceTo() == 1) {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("ToMars_Cabin.fxml"));
            Parent parent = loader.load();
            Scene scene = new Scene(parent);
            Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
            window.setScene(scene);
            window.show();
        } else {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("ToMars_EventTickets.fxml"));
            Parent parent = loader.load();
            Scene eventTicketsScene = new Scene(parent);
            Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
            window.setScene(eventTicketsScene);
            window.show();
        }
    }

    /**
     * Starts next scene. Opens FromMars_Cabin
     * @param event user pressed next button to move forward in the booking process
     * @throws IOException
     */
    @FXML
    void openCabinFromMars(ActionEvent event) throws IOException {
        checkSelectedDate();
        checkCheckBoxSelected();

        if (!(Order.getHotelOnMars() == 0)) {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("FromMars_Cabin.fxml"));
            Parent parent = loader.load();
            Scene CabinFromMarsScene = new Scene(parent);
            Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
            window.setScene(CabinFromMarsScene);
            window.show();
        }
        else {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("OnMars_Hotel_NoChoiceMade.fxml"));
            Parent parent = loader.load();
            Scene OnMars_Hotel_Error = new Scene(parent);
            Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
            window.setScene(OnMars_Hotel_Error);
            window.show();
        }
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
