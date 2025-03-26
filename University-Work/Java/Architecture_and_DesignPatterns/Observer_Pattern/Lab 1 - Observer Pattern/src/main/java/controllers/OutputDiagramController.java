package controllers;

import java.net.URL;
import java.util.List;
import java.util.ResourceBundle;

import controllers.cInterfaces.IControllerWithLifeCycle;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.chart.LineChart;
import javafx.scene.chart.NumberAxis;
import javafx.scene.chart.XYChart;
import javafx.scene.layout.Pane;
import observers.IObserver;
import observers.ISubject;
import state.StateStore;


public class OutputDiagramController implements Initializable, IControllerWithLifeCycle, IObserver {

    @FXML
    private Pane diagramPane;

    private LineChart<Number, Number> lineChart;

    //initialize runs when the view becomes visable, note that this happens everytime visable == true.
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        createChart();
    }

    public OutputDiagramController(){
        ISubject subject = StateStore.getInstance();
        subject.register(this);
    }

    private void createChart() {
        //defining the axes
        final NumberAxis xAxis = new NumberAxis();
        final NumberAxis yAxis = new NumberAxis();
        xAxis.setLabel("Days");
        //creating the chart
        lineChart = new LineChart<>(xAxis, yAxis);

        lineChart.setTitle("Chance of rain in the comming days");

        diagramPane.getChildren().add(lineChart);
        lineChart.getData().add(getSeries());
    }


    private XYChart.Series getSeries() {
        //defining a series
        XYChart.Series series = new XYChart.Series();
        series.setName("Rain change in %");
        //populating the series with data
        List rainList = StateStore.getInstance().getState().getOutRainDigramCalc();

        for (int i = 0; i < rainList.size(); i++) {
            series.getData().add(new XYChart.Data(i + 1, rainList.get(i)));
        }

        return series;
    }

    //Kan anropas för att uppdatera diagrammet.
    private void updateChartSeries() {
        lineChart.getData().remove(0);
        lineChart.getData().add(getSeries());
    }

    //willUnmount runs when the view is about to go out of view from user, good place for cleanup and releasing resources.
    @Override
    public void willUnmount() {
        System.out.println("Will unmount!!");
    }

    public void update() {
        updateChartSeries();
    }
}