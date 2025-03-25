package MarsTravel;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;
import javafx.scene.text.Font;
import javafx.scene.text.FontPosture;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import javafx.stage.Stage;

import java.io.IOException;

/**
 * Scene for information about hotels
 */
public class Info_Hotel_Controller {

    @FXML
    private Button btnCancel;

    /**
     * Builds a string with information from database about Hotel option
     * @param opt hotel option
     * @return string with information about hotel option
     */
    private String getHotelInfoQuery (int opt) {
        return  DatabaseConnect.databaseQuery("SELECT hotel_namn FROM hotel WHERE hotel_ID = " + opt, "hotel_namn") +
                "\n" +
                DatabaseConnect.databaseQuery("SELECT hotel_description FROM hotel WHERE hotel_ID = " + opt, "hotel_description") +
                "\n" + DatabaseConnect.databaseQuery("SELECT room_type FROM hotel WHERE hotel_ID = " + opt, "room_type") + " pris: " +
                DatabaseConnect.databaseQuery("SELECT price FROM hotel WHERE hotel_ID = " + opt, "price") + "kr/bädd" +
                "\n\n";
    }
    private String getHotelInfoQuery2 (int opt, int opt2) {
        return DatabaseConnect.databaseQuery("SELECT hotel_namn FROM hotel WHERE hotel_ID = " + opt, "hotel_namn") +
                "\n" +
                DatabaseConnect.databaseQuery("SELECT hotel_description FROM hotel WHERE hotel_ID = " + opt, "hotel_description") +
                "\n" + DatabaseConnect.databaseQuery("SELECT room_type FROM hotel WHERE hotel_ID = " + opt, "room_type") + " pris: " +
                DatabaseConnect.databaseQuery("SELECT price FROM hotel WHERE hotel_ID = " + opt, "price") + "kr" +
                "\n" + DatabaseConnect.databaseQuery("SELECT room_type FROM hotel WHERE hotel_ID = " + opt2, "room_type") + " pris: " +
                DatabaseConnect.databaseQuery("SELECT price FROM hotel WHERE hotel_ID = " + opt2, "price") + "kr" +
                "\n\n";
    }
    private String getHotelInfoQuery3 (int opt, int opt2, int opt3) {
        return DatabaseConnect.databaseQuery("SELECT hotel_namn FROM hotel WHERE hotel_ID = " + opt, "hotel_namn") +
                "\n" +
                DatabaseConnect.databaseQuery("SELECT hotel_description FROM hotel WHERE hotel_ID = " + opt, "hotel_description") +
                "\n" + DatabaseConnect.databaseQuery("SELECT room_type FROM hotel WHERE hotel_ID = " + opt, "room_type") + " pris: " +
                DatabaseConnect.databaseQuery("SELECT price FROM hotel WHERE hotel_ID = " + opt, "price") + "kr" +
                "\n" + DatabaseConnect.databaseQuery("SELECT room_type FROM hotel WHERE hotel_ID = " + opt2, "room_type") + " pris: " +
                DatabaseConnect.databaseQuery("SELECT price FROM hotel WHERE hotel_ID = " + opt2, "price") + "kr" +
                "\n" + DatabaseConnect.databaseQuery("SELECT room_type FROM hotel WHERE hotel_ID = " + opt3, "room_type") + " pris: " +
                DatabaseConnect.databaseQuery("SELECT price FROM hotel WHERE hotel_ID = " + opt3, "price") + "kr" +
                "\n\n";
    }


    //Builds string with gathered information about all cabins
    String hotelInfoAlternative = getHotelInfoQuery(1) + getHotelInfoQuery(2) +
            getHotelInfoQuery2(3, 4) + getHotelInfoQuery2(5, 6) + getHotelInfoQuery3(7, 8, 9);


    @FXML
    private Button btnBack;

    @FXML
    private TextArea txtHotelInfo;

    /**
     * Opens scene
     */
    @FXML
    private void initialize() {
        txtHotelInfo.setEditable(false);
        txtHotelInfo.setText(hotelInfoAlternative);
    }

    /**
     * Closes scene HotelInfo
     * @param event user pressed button for going back to scene for booking hotels on Mars
     * @throws IOException
     */
    @FXML
    public void openHotelInfoOnMarsScene (ActionEvent event) throws IOException {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("OnMars_Hotel.fxml"));
        Parent parent = loader.load();
        Scene hotelInfoScene = new Scene(parent);
        Stage window  = (Stage) ((Node)event.getSource()).getScene().getWindow();
        window.setScene(hotelInfoScene);
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
