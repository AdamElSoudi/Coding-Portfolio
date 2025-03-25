package MarsTravel;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;
import javafx.stage.Stage;

import java.io.IOException;

/**
 * Scene for information about cabins
 */
public class FromMars_Info_Cabin_Controller {
    @FXML
    private Button btnCancel;

    /**
     * Builds a string with information from database about cabin option
     * @param opt cabin option
     * @return string with information about cabin option
     */
    private String getCabinInfoQuery (int opt) {
        return DatabaseConnect.databaseQuery("SELECT cabin_type FROM cabin_types WHERE cabin_type_ID = " + opt, "cabin_type") +
                "\n" +
                DatabaseConnect.databaseQuery("SELECT description FROM cabin_types WHERE cabin_type_ID = " + opt, "description") +
                "\n" + "Pris: " +
                DatabaseConnect.databaseQuery("SELECT price FROM cabin_types WHERE cabin_type_ID = " + opt, "price") + "kr/person" +
                "\n\n";
    }
    //Builds string with gathered information about all cabins
    String cabinInfoAlternative = getCabinInfoQuery(2) + getCabinInfoQuery(3) +
            getCabinInfoQuery(4) + getCabinInfoQuery(5) + getCabinInfoQuery(1);


    @FXML
    private Button btnBack;

    @FXML
    private TextArea txtCabinInfo;

    /**
     * Opens scene
     */
    @FXML
    private void initialize() {
        txtCabinInfo.setEditable(false);
        txtCabinInfo.setText(cabinInfoAlternative);
    }

    /**
     * Closes scene with CabinInfo
     * @param event user pressed button for going back to scene for booking cabin from Mars
     * @throws IOException
     */
    @FXML
    public void openCabinFromMarsScene (ActionEvent event) throws IOException {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("FromMars_Cabin.fxml"));
        Parent parent = loader.load();
        Scene cabinInfoScene = new Scene(parent);
        Stage window  = (Stage) ((Node)event.getSource()).getScene().getWindow();
        window.setScene(cabinInfoScene);
        window.show();
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
