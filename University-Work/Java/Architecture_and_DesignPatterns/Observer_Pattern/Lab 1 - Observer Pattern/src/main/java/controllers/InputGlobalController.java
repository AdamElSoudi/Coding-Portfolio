
package controllers;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.Slider;
import state.StateStore;


public class InputGlobalController implements Initializable {
    
    @FXML
    private Slider slidLuck;
    @FXML
    private Slider slidRisk;
    @FXML
    private Slider slidFail;
    @FXML
    private Label lblLuckValue;
    @FXML
    private Label lblRiskValue;
    @FXML
    private Label lblFailValue;
    
    @FXML
    private void onLuckDragDone() {
        StateStore.getInstance().updateInValues("luck", (int) slidLuck.getValue());
        lblLuckValue.setText(String.format("%.0f", slidLuck.getValue()));
    }
    @FXML
    private void onRiskDragDone() {
        StateStore.getInstance().updateInValues("risk", (int) slidRisk.getValue());
        lblRiskValue.setText(String.format("%.0f", slidRisk.getValue()));
    }
    @FXML
    private void onFailDragDone() {
        StateStore.getInstance().updateInValues("fail", (int) slidFail.getValue());
        lblFailValue.setText(String.format("%.0f", slidFail.getValue()));
    }
    
    @Override
    public void initialize(URL url, ResourceBundle rb) {
    }
}
