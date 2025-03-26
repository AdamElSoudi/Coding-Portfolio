package controllers;

import Rules.Base64Lang;
import Rules.RubberLanguage;
import Rules.SuperImplementation;
import files.IMessageSaver;
import files.SaveMessageToFile;
import java.net.URL;
import java.util.ResourceBundle;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.CheckBox;
import javafx.scene.control.TextField;

/**
 * FXML Controller class
 *
 * @author marre
 */
public class MainWindowController implements Initializable {

    @FXML
    private CheckBox cbRubberyLang;
    @FXML
    private CheckBox cbBase64;
    @FXML
    private CheckBox cbSuperImp;
    @FXML
    private TextField txtMessage;

    private IMessageSaver messageSaver;
    
     /**
     * Initializes the controller class.
     *
     * @param url
     * @param rb
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        messageSaver = new SaveMessageToFile();
    }

    @FXML
    private void handleInsertButton() {
        String message = txtMessage.getText();
        if(message.length() == 0) {
            showAlert("Please insert a text message first.", "Fail");
            return;
        }
        
        try {
            String fileSaved = messageSaver.saveMessage(message);
            showAlert("Text message saved in file: " + fileSaved, "Success");
        } catch (Exception ex) {
            showAlert(ex.getMessage(), "Fail");
        } finally {
            txtMessage.setText("");
        }
    }

    @FXML
    private void handleCbChange() throws Exception {
        boolean rubberyChecked = cbRubberyLang.isSelected();
        boolean base64Checked = cbBase64.isSelected();
        boolean superImpChecked = cbSuperImp.isSelected();

        System.out.println("Rubbery selected: " + rubberyChecked);
        System.out.println("Base64 selected: " + base64Checked);
        System.out.println("Super implementation selected: " + superImpChecked);

        messageSaver = new SaveMessageToFile();

        if(rubberyChecked){
            this.messageSaver = new RubberLanguage(messageSaver);
        }
        if(base64Checked){
            this.messageSaver = new Base64Lang(messageSaver);
        }
        if(superImpChecked){
            this.messageSaver = new SuperImplementation(messageSaver);
        }
    }



    private void showAlert(String message, String title) {
        Alert alert = new Alert(AlertType.INFORMATION);
        alert.setTitle(title);
        alert.setContentText(message);
        alert.setHeaderText(null);

        alert.showAndWait();
    }
}