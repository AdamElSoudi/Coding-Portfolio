
package MarsTravel;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.stage.Stage;

import java.io.IOException;

/**
 * Error message scene
 * Opens if no choice is made in scene for booking cabin on journey from Mars
 */
public class FromMars_Cabin_NoChoiceMade_Controller {
    @FXML
    private Button btnCancel;

    @FXML
    private Button btnBack;

    @FXML
    private Label lblNoChoiceMadeCabinsFromMars;

    /**
     * Opens scene for booking cabin on journey from Mars
     * @param event user pressed button for going back to scene for booking cabin from Mars
     * @throws IOException
     */
    @FXML
    void openCabinFromMarsScene(ActionEvent event) throws IOException {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("FromMars_Cabin.fxml"));
        Parent parent = loader.load();
        Scene cabinFromMarsNoChoiceMadeScene = new Scene(parent);
        Stage window  = (Stage) ((Node)event.getSource()).getScene().getWindow();
        window.setScene(cabinFromMarsNoChoiceMadeScene);
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