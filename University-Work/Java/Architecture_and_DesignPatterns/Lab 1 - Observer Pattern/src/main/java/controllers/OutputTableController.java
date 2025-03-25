package controllers;

import java.net.URL;
import java.util.ResourceBundle;

import controllers.cInterfaces.IControllerWithLifeCycle;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import observers.IObserver;
import observers.ISubject;
import state.StateStore;
import state.State;


public class OutputTableController implements Initializable, IControllerWithLifeCycle, IObserver {

    @FXML
    private Label lblRain;

    //initialize runs when the view becomes visable, note that this happens everytime visable == true.
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        StateStore stateStore = StateStore.getInstance();

        State state = stateStore.getState();

        lblRain.setText(String.valueOf(state.getOutRainingCalc()));
        
    }
        private ISubject subject;

    public OutputTableController(){
        subject = StateStore.getInstance();
        subject.register(this);
    }

    //willUnmount runs when the view is about to go out of view from user, good place for cleanup and releasing resources.
    @Override
    public void willUnmount() {
        System.out.println("Will unmount!!");
        subject.unregister(this);
    }

    public void update(){
        StateStore stateStore = StateStore.getInstance();
        State state = stateStore.getState();
        lblRain.setText(String.valueOf(state.getOutRainingCalc()));
    }
}
