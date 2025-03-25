package MarsTravel;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.stage.Stage;

import java.io.IOException;


/**
 *Scene for booking of cabin to Mars
 */
public class ToMars_Cabin_Controller {

    @FXML
    private Button btnBack;

    @FXML
    private Button btnCancel;

    @FXML
    private Button btnNext;

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

    /**
     * Calls to database to get names of cabin options for display on buttons
     */
    private void display() {
        opt1.setText(DatabaseConnect.databaseQuery("SELECT cabin_type FROM cabin_types WHERE cabin_type_ID = 2", "cabin_type"));
        opt2.setText(DatabaseConnect.databaseQuery("SELECT cabin_type FROM cabin_types WHERE cabin_type_ID = 3", "cabin_type"));
        opt3.setText(DatabaseConnect.databaseQuery("SELECT cabin_type FROM cabin_types WHERE cabin_type_ID = 4", "cabin_type"));
        opt4.setText(DatabaseConnect.databaseQuery("SELECT cabin_type FROM cabin_types WHERE cabin_type_ID = 5", "cabin_type"));
        opt5.setText(DatabaseConnect.databaseQuery("SELECT cabin_type FROM cabin_types WHERE cabin_type_ID = 1", "cabin_type"));
    }

    /**
     * Starts scene
     */
    @FXML
    private void initialize() {
        display();
        setStartCheckbox();
    }

    /**
     * Gets choice from Order to checkboxes.
     * Used in case of going backwards in booking process.
     */
    private void setStartCheckbox() {
        if (Order.getCabinChoiceTo() == 0) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
        } else if (Order.getCabinChoiceTo() == 2) {
            opt1.setSelected(true);
        } else if (Order.getCabinChoiceTo() == 3) {
            opt2.setSelected(true);
        } else if (Order.getCabinChoiceTo() == 4) {
            opt3.setSelected(true);
        } else if (Order.getCabinChoiceTo() == 5) {
            opt4.setSelected(true);
        } else if (Order.getCabinChoiceTo() == 1) {
            opt5.setSelected(true);
        }
    }

    /**
     * Prohibits multiple choice.
     * Saves choice to Order.
     * @param event checkbox checked
     * @throws IOException
     */
    @FXML
    public void checkBoxSetSelected(ActionEvent event) throws IOException {

        if (event.getSource().equals(opt1)) {
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            Order.setCabinChoiceTo(2);

        } else if (event.getSource().equals(opt2)) {
            opt1.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            Order.setCabinChoiceTo(3);

        } else if (event.getSource().equals(opt3)) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt4.setSelected(false);
            opt5.setSelected(false);
            Order.setCabinChoiceTo(4);

        } else if (event.getSource().equals(opt4)) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt5.setSelected(false);
            Order.setCabinChoiceTo(5);

        } else if (event.getSource().equals(opt5)) {
            opt1.setSelected(false);
            opt2.setSelected(false);
            opt3.setSelected(false);
            opt4.setSelected(false);
            Order.setCabinChoiceTo(1);
        }
    }

    /**
     * Controls that a checkbox is selected and else sets choice in Order to 0
     */
    private void checkCheckBoxSelected() {
        if (!(opt1.isSelected() || opt2.isSelected() || opt3.isSelected() || opt4.isSelected() || opt5.isSelected())) {
            Order.setCabinChoiceTo(0);
        }
    }

    /**
     * Opens scene for cabin info
     * @param event user pressed button for info about cabins
     * @throws IOException
     */
    @FXML
    public void openCabinInfoScene(ActionEvent event) throws IOException {
        checkCheckBoxSelected();

        FXMLLoader loader = new FXMLLoader(getClass().getResource("ToMars_Info_Cabin.fxml"));
        Parent parent = loader.load();
        Scene cabinInfoScene = new Scene(parent);
        Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
        window.setScene(cabinInfoScene);
        window.show();
    }

    /**
     * Back button. Sends to previous view in booking process.
     * @param event user pressed button to go back in the booking process.
     * @throws IOException
     */
    @FXML
    void btnBack(ActionEvent event) throws IOException{
        checkCheckBoxSelected();

        FXMLLoader loader = new FXMLLoader(getClass().getResource("ToMars_Departure.fxml"));
        Parent parent = loader.load();
        Scene scene = new Scene(parent);
        Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
        window.setScene(scene);
        window.show();

    }

    /**
     * Checks if choice of cabin is made.
     * If choice is made: opens next scene in booking process
     * If choice not made: opens error message scene
     * @param event user pressed button for moving forward in the booking process
     * @throws IOException
     */
    @FXML
    public void openFoodBundleToMars(ActionEvent event) throws IOException {
        checkCheckBoxSelected();

        //Correct case if choice is option 1 to 4
        if(opt1.isSelected() || opt2.isSelected() || opt3.isSelected() || opt4.isSelected()) {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("ToMars_FoodBundle.fxml"));
            Parent parent = loader.load();
            Scene foodBundleToMarsScene = new Scene(parent);
            Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
            window.setScene(foodBundleToMarsScene);
            window.show();
        }
        //Correct case if choice is option 5 which means no need of food bundle or event tickets
        else if (opt5.isSelected()) {
            Order.setFoodBundleChoiceTo(10);

            FXMLLoader loader = new FXMLLoader(getClass().getResource("OnMars_Hotel.fxml"));
            Parent parent = loader.load();
            Scene HotelScene = new Scene(parent);
            Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
            window.setScene(HotelScene);
            window.show();
        }
        //Error message if no choice made
        else {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("ToMars_Cabin_NoChoiceMade.fxml"));
            Parent parent = loader.load();
            Scene CabinToMarsNoChoiceMadeScene = new Scene(parent);
            Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
            window.setScene(CabinToMarsNoChoiceMadeScene);
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
