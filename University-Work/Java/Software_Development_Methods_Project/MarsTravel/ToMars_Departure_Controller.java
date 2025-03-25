package MarsTravel;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.Label;
import javafx.stage.Stage;

import java.awt.event.ActionEvent;
import java.io.IOException;
import java.time.LocalDate;

/**
 * Scene for date selection. First scene in application
 */
public class ToMars_Departure_Controller {

    @FXML
    private Button btnNext;

    @FXML
    private ChoiceBox<LocalDate> chDateChoice;

    @FXML
    private Label lblAvgang;


    private LocalDate trip0 = LocalDate.of(2022, 03,15);
    private LocalDate trip1 = LocalDate.of(2023, 1, 1);
    private LocalDate trip2 = LocalDate.of(2023, 2, 1);
    private LocalDate trip3 = LocalDate.of(2023, 3, 1);
    private LocalDate trip4 = LocalDate.of(2023, 4, 1);
    private LocalDate trip5 = LocalDate.of(2023, 5, 1);
    private LocalDate trip6 = LocalDate.of(2023, 6, 1);
    private LocalDate trip7 = LocalDate.of(2023, 7, 1);
    private LocalDate trip8 = LocalDate.of(2023, 8, 1);

    private ObservableList<LocalDate> datesTo = FXCollections.observableArrayList(trip0, trip1, trip2, trip3, trip4, trip5, trip6, trip7, trip8);

    /**
     * Starts scene
     */
    @FXML
    private void initialize() {

        setSelected();
    }

    /**
     * Sets the first date selected to be after the current date.
     * No dates after current date.
     */
    @FXML
    private void setSelected() {

        ObservableList<LocalDate> datesToAvailable = FXCollections.observableArrayList();
        for (LocalDate date : datesTo) {
            if (date.isEqual(LocalDate.now()) || date.isAfter(LocalDate.now())) {
                datesToAvailable.add(date);
            }
        }
        if (Order.getDepartureTo() != null) {
            chDateChoice.setValue(Order.getDepartureTo());
        } else {
            chDateChoice.setValue(datesToAvailable.get(0));

        }
        chDateChoice.setItems(datesToAvailable);
    }

    /**
     * Sends selected date to Order class to be stored for future use.
     * @throws IOException
     */
    @FXML
    public void checkSelectedDate() throws IOException {
        Order.setDepartureTo(chDateChoice.getValue());
    }

    /**
     * Opens next scene. Starts ToMars_Cabin scene.
     * @param event user pressed button to go forward in the booking process.
     * @throws IOException
     */
    @FXML
    public void openCabinToMars(javafx.event.ActionEvent event) throws IOException {
        checkSelectedDate();
        if (Order.getDepartureTo() != null) {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("ToMars_Cabin.fxml"));
            Parent parent = loader.load();
            Scene scene = new Scene(parent);
            Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
            window.setScene(scene);
            window.show();
        } else {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("ToMars_Departure_NoChoiceMade.fxml"));
            Parent parent = loader.load();
            Scene eventTicketsScene = new Scene(parent);
            Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
            window.setScene(eventTicketsScene);
            window.show();
        }
    }
}
