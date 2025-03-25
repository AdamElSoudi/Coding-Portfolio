package MarsTravel;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.scene.control.Label;
import javafx.stage.Stage;

import java.io.IOException;

/**
 * Scene for choosing food bundle on journey from Mars
 */
public class FromMars_FoodBundle_Controller {

    @FXML
    private Button btnCancel;

    @FXML
    private Button btnFoodBundleInfoFrom;

    @FXML
    private Button btnSave;

    @FXML
    private Label lblFoodBundleFromMars;

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

    /**
     * Calls to database to get names of food bundle options for display on buttons
     */
    private void display() {
        opt1.setText(DatabaseConnect.databaseQuery("SELECT bundle_name FROM food_bundle WHERE bundle_ID = 1", "bundle_name"));
        opt2.setText(DatabaseConnect.databaseQuery("SELECT bundle_name FROM food_bundle WHERE bundle_ID = 2", "bundle_name"));
        opt3.setText(DatabaseConnect.databaseQuery("SELECT bundle_name FROM food_bundle WHERE bundle_ID = 3", "bundle_name"));
        opt4.setText(DatabaseConnect.databaseQuery("SELECT bundle_name FROM food_bundle WHERE bundle_ID = 4", "bundle_name"));
        opt5.setText(DatabaseConnect.databaseQuery("SELECT bundle_name FROM food_bundle WHERE bundle_ID = 5", "bundle_name"));
        opt6.setText(DatabaseConnect.databaseQuery("SELECT bundle_name FROM food_bundle WHERE bundle_ID = 6", "bundle_name"));
        opt7.setText(DatabaseConnect.databaseQuery("SELECT bundle_name FROM food_bundle WHERE bundle_ID = 7", "bundle_name"));
        opt8.setText(DatabaseConnect.databaseQuery("SELECT bundle_name FROM food_bundle WHERE bundle_ID = 8", "bundle_name"));
        opt9.setText(DatabaseConnect.databaseQuery("SELECT bundle_name FROM food_bundle WHERE bundle_ID = 9", "bundle_name"));
    }

    /**
     * Starts scene
     */
    @FXML
    private void initialize() {
        display();
        checkBoxSetSelected();
    }


    /**
     * Prohibits multiple choice
     * Saves choice to Order
     * @param event checkbox checked
     * @throws IOException
     */
    @FXML
    void checkboxSelected(ActionEvent event) throws IOException {

        if (event.getSource().equals(opt1)) {
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            opt6.setSelected(false);
            opt7.setSelected(false);
            opt8.setSelected(false);
            opt9.setSelected(false);
            Order.setFoodBundleChoiceFrom(1);


        } else if (event.getSource().equals(opt2)) {
            opt1.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            opt6.setSelected(false);
            opt7.setSelected(false);
            opt8.setSelected(false);
            opt9.setSelected(false);
            Order.setFoodBundleChoiceFrom(2);


        } else if (event.getSource().equals(opt3)) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            opt6.setSelected(false);
            opt7.setSelected(false);
            opt8.setSelected(false);
            opt9.setSelected(false);
            Order.setFoodBundleChoiceFrom(3);


        } else if (event.getSource().equals(opt4)) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt5.setSelected(false);
            opt6.setSelected(false);
            opt7.setSelected(false);
            opt8.setSelected(false);
            opt9.setSelected(false);
            Order.setFoodBundleChoiceFrom(4);


        } else if (event.getSource().equals(opt5)) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt6.setSelected(false);
            opt7.setSelected(false);
            opt8.setSelected(false);
            opt9.setSelected(false);
            Order.setFoodBundleChoiceFrom(5);


        } else if (event.getSource().equals(opt6)) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            opt7.setSelected(false);
            opt8.setSelected(false);
            opt9.setSelected(false);
            Order.setFoodBundleChoiceFrom(6);


        } else if (event.getSource().equals(opt7)) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            opt6.setSelected(false);
            opt8.setSelected(false);
            opt9.setSelected(false);
            Order.setFoodBundleChoiceFrom(7);


        } else if (event.getSource().equals(opt8)) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            opt6.setSelected(false);
            opt7.setSelected(false);
            opt9.setSelected(false);
            Order.setFoodBundleChoiceFrom(8);


        } else if (event.getSource().equals(opt9)) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            opt6.setSelected(false);
            opt7.setSelected(false);
            opt8.setSelected(false);
            Order.setFoodBundleChoiceFrom(9);
        }
    }

    /**
     * Gets choice from Order
     * Used in case of going backwards in booking process
     */
    private void checkBoxSetSelected() {
        if (Order.getFoodBundleChoiceFrom() == 0) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            opt6.setSelected(false);
            opt7.setSelected(false);
            opt8.setSelected(false);
            opt9.setSelected(false);
        } else if (Order.getFoodBundleChoiceFrom() == 1) {
            opt1.setSelected(true);
        } else if (Order.getFoodBundleChoiceFrom() == 2) {
            opt2.setSelected(true);
        } else if (Order.getFoodBundleChoiceFrom() == 3) {
            opt3.setSelected(true);
        } else if (Order.getFoodBundleChoiceFrom() == 4) {
            opt4.setSelected(true);
        } else if (Order.getFoodBundleChoiceFrom() == 5) {
            opt5.setSelected(true);
        } else if (Order.getFoodBundleChoiceFrom() == 6) {
            opt6.setSelected(true);
        } else if (Order.getFoodBundleChoiceFrom() == 7) {
            opt7.setSelected(true);
        } else if (Order.getFoodBundleChoiceFrom() == 8) {
            opt9.setSelected(true);
        } else if (Order.getFoodBundleChoiceFrom() == 9) {
            opt9.setSelected(true);
        }
    }

    /**
     * Controls that a checkbox is selected and else sets choice in Order to 0
     */
    private void checkCheckBoxSelected() {
        if (!(opt1.isSelected() || opt2.isSelected() || opt3.isSelected() || opt4.isSelected() || opt5.isSelected() ||
                opt6.isSelected() || opt7.isSelected() || opt8.isSelected() || opt9.isSelected())) {
            Order.setFoodBundleChoiceFrom(0);
        }
    }

    /**
     * Opens scene with information about food bundles
     * @param event user pressed button for info about food bundles
     * @throws IOException
     */
    @FXML
    public void openFoodBundleInfoScene(ActionEvent event) throws IOException {
        checkCheckBoxSelected();

        FXMLLoader loader = new FXMLLoader(getClass().getResource("FromMars_Info_FoodBundle.fxml"));
        Parent parent = loader.load();
        Scene foodBundleInfoScene = new Scene(parent);
        Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
        window.setScene(foodBundleInfoScene);
        window.show();
    }

    /**
     * Opens previous scene in booking process, FromMars_Cabin
     * @param event user pressed button for going backwards in booking process
     * @throws IOException
     */
    @FXML
    public void openCabinFromMarsScene(ActionEvent event) throws IOException {
        checkCheckBoxSelected();

        FXMLLoader loader = new FXMLLoader(getClass().getResource("FromMars_Cabin.fxml"));
        Parent parent = loader.load();
        Scene scene = new Scene(parent);
        Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
        window.setScene(scene);
        window.show();
    }


     /**
     * Checks if choice of food bundle is made.
     * If choice is made: opens next scene in booking process
     * If choice not made: opens error message scene
     * @param event user pressed button for moving forward in the booking process
     * @throws IOException
     */
    @FXML
    public void openEventTicketsFromMarsScene(ActionEvent event) throws IOException {
        checkCheckBoxSelected();

        if (!(Order.getFoodBundleChoiceFrom() == 0)) {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("FromMars_EventTickets.fxml"));
            Parent parent = loader.load();
            Scene eventTicketsFromMarsScene = new Scene(parent);
            Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
            window.setScene(eventTicketsFromMarsScene);
            window.show();

        } else { //Error message if no choice made
            FXMLLoader loader = new FXMLLoader(getClass().getResource("FromMars_FoodBundle_NoChoiceMade.fxml"));
            Parent parent = loader.load();
            Scene foodBundleFromMarsNoChoiceMadeScene = new Scene(parent);
            Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
            window.setScene(foodBundleFromMarsNoChoiceMadeScene);
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


