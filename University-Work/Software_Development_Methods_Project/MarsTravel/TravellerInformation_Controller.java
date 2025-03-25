package MarsTravel;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.effect.MotionBlur;
import javafx.stage.Stage;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.Month;
import java.time.temporal.ChronoUnit;

import static MarsTravel.Traveller.*;

/**
 * Controller class for TravellerInformation.fxml. Scene for inputting information about traveller.
 */
public class TravellerInformation_Controller {

        @FXML
        private TextField inputCreditCard;

        @FXML
        private Button btnCancel;

        @FXML
        private Button btnBack;

        @FXML
        private CheckBox chbHealthInsuranceYes;

        @FXML
        private CheckBox chbHealthInsuranceNo;

        @FXML
        private CheckBox chbChronicPainNo;

        @FXML
        private CheckBox chbChronicPainYes;

        @FXML
        private CheckBox chbHealthyNo;

        @FXML
        private CheckBox chbHealthyYes;

        @FXML
        private CheckBox chbMedsNo;

        @FXML
        private CheckBox chbMedsYes;

        @FXML
        private Button btnNext;

        @FXML
        private TextField inputAddress;

        @FXML
        private TextField inputEmail;

        @FXML
        private TextField inputFirstName;

        @FXML
        private TextField inputLastName;

        @FXML
        private TextField inputPersonalNumber;

        @FXML
        private Label lblChronicPain;

        @FXML
        private Label lblHealthInsurancePrice;

        @FXML
        private Label lblHealthyQuestion;

        @FXML
        private Label lblMedication;

        @FXML
        private Label lblTravellerInfoQuestion;

        @FXML
        private Separator separator;

        @FXML
        private TextField inputChronicPain;

        @FXML
        private TextField inputMedicine;

        @FXML
        private Label lblNotEnough;

        /**
         * starts scene
         */
        public void initialize(){
                setStart();
        }

        /**
         * Gets choice from Traveller to checkboxes and text fields.
         * Used in case of going backwards in booking process.
         */
        public void setStart(){
                inputPersonalNumber.setText(Traveller.getPersonalNumber());
                inputFirstName.setText(Traveller.getFirstName());
                inputLastName.setText(Traveller.getLastName());
                inputEmail.setText(Traveller.getEmail());
                inputAddress.setText(Traveller.getAddress());
                inputChronicPain.setText(Traveller.getChronicPainText());
                inputMedicine.setText(Traveller.getMedicineText());

                inputCreditCard.setText(Traveller.getCreditCard());

                if (Traveller.getHealthy() == 0) {
                        chbHealthyYes.setSelected(false);
                        chbHealthyNo.setSelected(false);
                } else if (Traveller.getHealthy() == 1) {
                        chbHealthyYes.setSelected(true);
                } else if (Traveller.getHealthy() == 2) {
                        chbHealthyNo.setSelected(true);
                }

                if (Traveller.getChronicPain() == 0) {
                        chbChronicPainYes.setSelected(false);
                        chbChronicPainNo.setSelected(false);
                } else if (Traveller.getChronicPain() == 1) {
                        chbChronicPainYes.setSelected(true);
                } else if (Traveller.getChronicPain() == 2) {
                        chbChronicPainNo.setSelected(true);
                }

                if (Traveller.getMedicine() == 0) {
                        chbMedsYes.setSelected(false);
                        chbMedsNo.setSelected(false);
                } else if (Traveller.getMedicine() == 1) {
                        chbMedsYes.setSelected(true);
                } else if (Traveller.getMedicine() == 2) {
                        chbMedsNo.setSelected(true);
                }

                if (Traveller.getHealthInsurance() == 0) {
                        chbHealthInsuranceYes.setSelected(false);
                        chbHealthInsuranceNo.setSelected(false);
                } else if (Traveller.getHealthInsurance() == 1) {
                        chbHealthInsuranceYes.setSelected(true);
                } else if (Traveller.getHealthInsurance() == 2) {
                        chbHealthInsuranceNo.setSelected(true);
                }
        }

        @FXML
        void healthy(ActionEvent event) {
                if (event.getSource().equals(chbHealthyYes)) {
                        chbHealthyNo.setSelected(false);
                        setHealthy(1);
                } else if (event.getSource().equals(chbHealthyNo)) {
                        chbHealthyYes.setSelected(false);
                        setHealthy(2);
                }
        }

        @FXML
        void chronicPain(ActionEvent event) {
                if (event.getSource().equals(chbChronicPainYes)) {
                        chbChronicPainNo.setSelected(false);
                        setChronicPain(1);
                } else if (event.getSource().equals(chbChronicPainNo)){
                        chbChronicPainYes.setSelected(false);
                        setChronicPain(2);
                }
        }

        @FXML
        void medicine(ActionEvent event) {
                if (event.getSource().equals(chbMedsYes)) {
                        chbMedsNo.setSelected(false);
                        setMedicine(1);
                } else if (event.getSource().equals(chbMedsNo)){
                        chbMedsYes.setSelected(false);
                        setMedicine(2);
                }
        }

        @FXML
        void healthInsurance(ActionEvent event) {
                if (event.getSource().equals(chbHealthInsuranceYes)) {
                        chbHealthInsuranceNo.setSelected(false);
                        setHealthInsurance(1);
                } else if (event.getSource().equals(chbHealthInsuranceNo)){
                        chbHealthInsuranceYes.setSelected(false);
                        setHealthInsurance(2);
                }
        }

        private boolean checkCheckBoxes() {
                return (chbHealthInsuranceYes.isSelected() || chbHealthInsuranceNo.isSelected())
                        && (chbMedsYes.isSelected() || chbMedsNo.isSelected())
                        && (chbChronicPainYes.isSelected() || chbChronicPainNo.isSelected())
                        && (chbHealthyYes.isSelected() || chbHealthyNo.isSelected());
        }

        /**
         * Saves inputted information if user goes back or forward in booking process.
         */
        private void saveFields () {
                Traveller.setPersonalNumber(inputPersonalNumber.getText());
                Traveller.setFirstName(inputFirstName.getText());
                Traveller.setLastName(inputLastName.getText());
                Traveller.setEmail(inputEmail.getText());
                Traveller.setAddress(inputAddress.getText());
                Traveller.setChronicPainText(inputChronicPain.getText());
                Traveller.setMedicineText(inputMedicine.getText());

                if (inputCreditCard.getText() == "")
                        Traveller.setCreditCard("0");
                else
                        Traveller.setCreditCard(inputCreditCard.getText());
        }

        /**
         * Controls that a checkbox is selected and else sets choice in Traveller to 0
         */
        private void checkCheckBoxSelected() {
                if (!(chbHealthyYes.isSelected() || chbHealthyNo.isSelected())) {
                        Traveller.setHealthy(0);
                }
                if (!(chbChronicPainYes.isSelected() || chbChronicPainNo.isSelected())) {
                        Traveller.setChronicPain(0);
                }
                if (!(chbMedsYes.isSelected() || chbMedsNo.isSelected())) {
                        Traveller.setMedicine(0);
                }
                if (!(chbHealthInsuranceYes.isSelected() || chbHealthInsuranceNo.isSelected())) {
                        Traveller.setHealthInsurance(0);
                }
        }

        /**
         * Goes back to previous scene. if "Sömnkapsel" is chosen, sends back to FromMars_Cabin.
         * If any other option is chosen, sends back to FromMars_EventTickets.
         * @param event user pressed button to go back in booking process.
         * @throws IOException
         */
        @FXML
        void btnBack(ActionEvent event) throws IOException {
                checkCheckBoxSelected();
                saveFields();
                if(Order.getCabinChoiceFrom() == 1) {
                        FXMLLoader loader = new FXMLLoader(getClass().getResource("FromMars_Cabin.fxml"));
                        Parent parent = loader.load();
                        Scene scene = new Scene(parent);
                        Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
                        window.setScene(scene);
                        window.show();
                } else {
                        FXMLLoader loader = new FXMLLoader(getClass().getResource("FromMars_EventTickets.fxml"));
                        Parent parent = loader.load();
                        Scene scene = new Scene(parent);
                        Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
                        window.setScene(scene);
                        window.show();
                }
        }

        /**
         * Sends information to traveller to go forward. Goes to next scene.
         * @param event user pressed button to go forward in booking process
         * @throws IOException
         */
        @FXML
        void btnNext(ActionEvent event) throws IOException {
                checkCheckBoxSelected();
                checkCheckBoxes();
                saveFields();

                if (Traveller.getCreditCard() == null || Integer.parseInt(Traveller.getCreditCard()) < 20000){
                        lblNotEnough.setText("Ogiltigt belopp");
                } else
                        if (Traveller.completed() && checkCheckBoxes()) {
                                FXMLLoader loader = new FXMLLoader(getClass().getResource("BookingOverview.fxml"));
                                Parent parent = loader.load();
                                Scene tiScene = new Scene(parent);
                                Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
                                window.setScene(tiScene);
                                window.show();

                        } else {
                                FXMLLoader loader = new FXMLLoader(getClass().getResource("TravellerInformation_NoChoiceMade.fxml"));
                                Parent parent = loader.load();
                                Scene tiScene = new Scene(parent);
                                Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
                                window.setScene(tiScene);
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


        public static String totalSum(){
                int totSum = 0;
                String totalSum = "";
                int insurance = 0;
                int debitCard = Integer.parseInt(Traveller.getCreditCard());
                long monthsBetween = ChronoUnit.MONTHS.between(Order.getDepartureTo().plusMonths(6), Order.getDepartureFrom());
                int months = (int) monthsBetween;

                int toCabin = Integer.parseInt(DatabaseConnect.databaseQuery("select price from cabin_types where cabin_type_ID = " + Order.getCabinChoiceTo() + ";", "price"));
                int toFood = Integer.parseInt(DatabaseConnect.databaseQuery("select price from food_bundle where bundle_ID = " + Order.getFoodBundleChoiceTo() + ";", "price"));
                int toEventMovies = Integer.parseInt(DatabaseConnect.databaseQuery("select price from event_types where event_types_ID = 2;", "price"));
                int toEventTheater = Integer.parseInt(DatabaseConnect.databaseQuery("select price from event_types where event_types_ID = 3;", "price"));
                int toEventConcert = Integer.parseInt(DatabaseConnect.databaseQuery("select price from event_types where event_types_ID = 1;", "price"));
                int hotel = Integer.parseInt(DatabaseConnect.databaseQuery("select price from hotel where hotel_ID = " + Order.getHotelOnMars() + ";", "price"));
                int fromCabin = Integer.parseInt(DatabaseConnect.databaseQuery("select price from cabin_types where cabin_type_ID = " + Order.getCabinChoiceFrom() + ";", "price"));
                int fromFood = Integer.parseInt(DatabaseConnect.databaseQuery("select price from food_bundle where bundle_ID = " + Order.getFoodBundleChoiceFrom() + ";", "price"));
                int fromEventMovies = Integer.parseInt(DatabaseConnect.databaseQuery("select price from event_types where event_types_ID = 2;", "price"));
                int fromEventTheater = Integer.parseInt(DatabaseConnect.databaseQuery("select price from event_types where event_types_ID = 3;", "price"));
                int fromEventConcert = Integer.parseInt(DatabaseConnect.databaseQuery("select price from event_types where event_types_ID = 1;", "price"));

                if(Traveller.getHealthInsurance() == 2) {
                        insurance = 0;
                } else {
                        insurance = 50000;
                }

                totSum = toCabin + toFood + (toEventMovies * Order.getMovieToMars())+ (toEventTheater * Order.getTheaterToMars())+ (toEventConcert * Order.getConcertToMars())+ (hotel * months) + fromCabin + fromFood + (fromEventMovies * Order.getMovieFromMars())+ (fromEventTheater * Order.getTheaterFromMars())+ (fromEventConcert * Order.getConcertFromMars()) + insurance + debitCard;

                totalSum = String.valueOf(totSum);
                return totalSum;
        }
}
