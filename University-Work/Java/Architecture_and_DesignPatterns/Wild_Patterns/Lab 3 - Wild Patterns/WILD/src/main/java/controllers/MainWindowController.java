package controllers;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

import factory.CommunicatorFactory;
import factory.IChat;
import factory.ICommunicator;
import factory.IFactory;
import javafx.beans.value.ObservableValue;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.RadioButton;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.scene.control.Toggle;
import javafx.scene.control.ToggleGroup;
import observer.IObserver;
import observer.ISubject;
import time.Timer;

/**
 * FXML Controller class
 *
 * @author Martin Goblirsch
 */
public class MainWindowController implements Initializable, ISubject, IChat {

    @FXML
    public TextArea txtAreaChat;
    @FXML
    public TextField txtMessage;
    @FXML
    public TextField txtName;
    @FXML
    public ToggleGroup gg;

    IFactory factory = new CommunicatorFactory();
    private List<IObserver> observers = new ArrayList<>();

    Timer tid = new Timer();

    //------------- Deluppgift A test:
    //Change what line is commented to change communicator:
    
    //private WebSocketCommunicator _communicator = new WebSocketCommunicator(this);
    //private UDPChatCommunicator _communicator = new UDPChatCommunicator(this);

    //-------------

    ICommunicator _communicator = factory.createComm("UDP", this);

    /**
     * Initializes the controller class.
     *
     * @param url
     * @param rb
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        _communicator.startListen();
        addRadioButtonListener();
    }

    /**
     * Receive message from user.
     *
     * @param message The received message.
     */
    public void receiveMessage(String message) {
        txtAreaChat.setText(txtAreaChat.getText() + "\n" + message);
        String[] split = message.split(":", 2);
        message = "Name: " + split[0] + ". Message:" + split[1]; // Correct format
        // for the log
        tid.tiden(message);
    }

    /**
     * Inform the user that an error has occurred and exit the application.
     *
     * @param e
     */
    public void error(Exception e) {
        showAlert("An error has occured and the application will close: \n" + e.getMessage(), "Error Error!");
        System.exit(1);
    }

    /**
     * Adds listener for radio buttons in the view. 
     */
    private void changeChat(String type) throws Exception {
        unregister(_communicator);
        _communicator.stopListen();
        _communicator = factory.createComm(type, this);
        register(_communicator);
        _communicator.startListen();
    }
    private void addRadioButtonListener() {
        gg.selectedToggleProperty().addListener((ObservableValue<? extends Toggle> ov, Toggle t, Toggle t1) -> {
            RadioButton chk = (RadioButton) t1.getToggleGroup().getSelectedToggle(); // Cast object to radio button
            System.out.println("Selected Radio Button - " + chk.getText());
            try {
                changeChat(chk.getText());
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        });
    }

    @FXML
    private void handleSendButton() {
        if (inputValid(txtName.getText(), txtMessage.getText())) {
            this.sendMessage(txtName.getText(), txtMessage.getText());
            txtMessage.setText("");
        }
    }

    private boolean inputValid(String name, String message) {
        if (name.length() == 0) {
            this.showAlert("Please write your name to use the chat", "Fail");
            return false;
        }
        if (message.length() == 0) {
            this.showAlert("Please write a real message.", "Fail");
            return false;
        }
        return true;
    }

    /**
     * Send current message to all users.
     */
    private void sendMessage(String name, String message) {
        try {
            notifyObs(name, message);
        } catch (Exception e) {
            this.error(e);
        }
    }

    private void showAlert(String message, String title) {
        Alert alert = new Alert(Alert.AlertType.INFORMATION);
        alert.setTitle(title);
        alert.setContentText(message);
        alert.setHeaderText(null);

        String log = "Title: " + title + ". Message: " + message;
        tid.tiden(log);

        alert.showAndWait();
    }


    @Override
    public void register(IObserver observer) {
        observers.add(observer);
    }

    @Override
    public void unregister(IObserver observer) {
        observers.remove(observer);
    }
    @Override
    public void notifyObs(String name, String message) throws Exception {
        for (IObserver observer : observers) {
            observer.update(name, message);
        }
    }
}
