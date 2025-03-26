package controllers;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

import controllers.cInterfaces.IControllerWithLifeCycle;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.control.Accordion;
import javafx.scene.control.TitledPane;
import javafx.scene.layout.AnchorPane;


public class MainWindowController implements Initializable {
    
    @FXML
    private Accordion accord;
    @FXML
    private TitledPane pane1,pane2,pane3;
    @FXML
    private AnchorPane centerStage;

    private FXMLLoader centerStageLoader;

    @FXML
    private void showDiagram(ActionEvent event) {
        populateCenterStage("/fxml/output_diagram.fxml");
    }
    @FXML
    private void showTable(ActionEvent event) {
        populateCenterStage("/fxml/output_table.fxml");
    }
    
    private void populateCenterStage(String view) {
        try {
            ObservableList<Node> children = centerStage.getChildren();
            if(children.size() > 0) {
                //get active controller class
                IControllerWithLifeCycle activeChild = centerStageLoader.getController();
                //run willUnmount on it (since FX dont have default lifecycle).
                activeChild.willUnmount();

                centerStage.getChildren().remove(0);
            }

            centerStageLoader = new FXMLLoader(getClass().getResource(view));
            children.add(centerStageLoader.load());

        } catch (IOException ex) {
            System.out.println(ex.getMessage());
        }
    }
    
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        try {
            pane1.setContent(FXMLLoader.load(getClass().getResource("/fxml/input_local.fxml")));
            pane2.setContent(FXMLLoader.load(getClass().getResource("/fxml/input_global.fxml")));
            populateCenterStage("/fxml/output_diagram.fxml");
        } catch (IOException ex) {
            System.out.println(ex.getMessage());
        }
        accord.setExpandedPane(pane1);
        
    }    
    
}
