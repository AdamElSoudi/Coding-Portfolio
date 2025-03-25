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
 * Scene for information about food bundles
 */
public class ToMars_Info_FoodBundle_Controller {

    @FXML
    private Button btnCancel;

    /**
     * Builds a string with information from database about food bundle option
     * @param opt food bundle option
     * @return string with information about food bundle option
     */
    private String getFoodBundleInfoQuery(int opt) {
        return
        DatabaseConnect.databaseQuery("SELECT bundle_name FROM food_bundle WHERE bundle_ID = " + opt, "bundle_name") +
                "\n" +
                DatabaseConnect.databaseQuery("SELECT bundle_description FROM food_bundle WHERE bundle_ID = " + opt, "bundle_description") +
                "\n" + "Pris: " +
                DatabaseConnect.databaseQuery("SELECT price FROM food_bundle WHERE bundle_ID = " + opt, "price") + "kr/person" +
                "\n\n";
    }
    //String with gathered information about all food bundle options
    String foodBundleInfo =
            getFoodBundleInfoQuery(1) + getFoodBundleInfoQuery(2) + getFoodBundleInfoQuery(3) +
                    getFoodBundleInfoQuery(4) + getFoodBundleInfoQuery(5) + getFoodBundleInfoQuery(6) +
                    getFoodBundleInfoQuery(7) + getFoodBundleInfoQuery(8) + getFoodBundleInfoQuery(9);

    /**
     * Builds a string with information from database about restaurant option
     * @param opt restaurant option
     * @return string with information about restaurant option
     */
    private String getRestaurantInfoQuery(int opt) {
        return
                DatabaseConnect.databaseQuery("SELECT restaurant_name FROM restaurants WHERE restaurants_ID = " + opt, "restaurant_name") +
                        "\n" +
                        DatabaseConnect.databaseQuery("SELECT restaurants_description FROM restaurants WHERE restaurants_ID = " + opt, "restaurants_description") +
                        "\n\n";
    }

    //Builds string with gathered information about all restaurants
    String restaurantInfo = getRestaurantInfoQuery(1) + getRestaurantInfoQuery(2) +
            getRestaurantInfoQuery(3) + getRestaurantInfoQuery(4);


    @FXML
    private Button btnBack;

    @FXML
    private Label lblFoodBundleInfo;

    @FXML
    private TextArea txtFoodBundleInfo;

    @FXML
    private TextArea txtRestaurantInfo;

    /**
     * Starts scene
     */
    @FXML
    private void initialize() {
        txtFoodBundleInfo.setEditable(false);
        txtFoodBundleInfo.setText(foodBundleInfo);
        txtRestaurantInfo.setEditable(false);
        txtRestaurantInfo.setText(restaurantInfo);
    }

    /**
     * Closes scene with food bundle information
     * @param event user pressed button for going back to scene for choosing food bundle on journey to Mars
     * @throws IOException
     */
    @FXML
    void openFoodBundleToMarsScene(ActionEvent event) throws IOException {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("ToMars_FoodBundle.fxml"));
            Parent parent = loader.load();
            Scene foodBundleInfoScene = new Scene(parent);
            Stage window  = (Stage) ((Node)event.getSource()).getScene().getWindow();
            window.setScene(foodBundleInfoScene);
            window.show();
        }
    @FXML

    /**
     * Cancels booking process and takes user back to date selection
     * @param event user pressed button for cancelling booking process
     * @throws IOException
     */
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

