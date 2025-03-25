
package controllers;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.Slider;
import state.StateStore;


public class InputLocalController implements Initializable {
      
    @FXML
    private Slider slidPollution;
    @FXML
    private Slider slidTime;
    @FXML
    private Label lblPollutionValue;
    @FXML
    private Label lblTimeValue;
    
    @FXML
    private void onPollutionDragDone() {
        StateStore.getInstance().updateInValues("pollution", (int) slidPollution.getValue());
        lblPollutionValue.setText(String.format("%.0f", slidPollution.getValue()));
    }
    @FXML
    private void onTimeDragDone() {
        StateStore.getInstance().updateInValues("time", (int) slidTime.getValue());
        lblTimeValue.setText(String.format("%.0f", slidTime.getValue()));
    }
    
    @Override
    public void initialize(URL url, ResourceBundle rb) {
    } 
    
}
