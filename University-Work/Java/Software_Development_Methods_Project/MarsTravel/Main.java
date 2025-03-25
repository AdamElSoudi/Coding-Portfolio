package MarsTravel;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class Main extends Application {



    /**
     * Starting point for booking program
     * @param primaryStage opens first scene
     * @throws Exception
     */
    @Override
    public void start(Stage primaryStage) throws Exception{
        Parent root = FXMLLoader.load(getClass().getResource("ToMars_Departure.fxml")); //TODO CHANGE FIRST SCENE HERE
        primaryStage.setTitle("MarsTravel");
        primaryStage.setScene(new Scene(root, 1000, 700));
        primaryStage.show();
        primaryStage.setMinWidth(1000);
        primaryStage.setMinHeight(700);
    }


    public static void main(String[] args) {
        launch(args);
    }
}
