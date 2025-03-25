package MarsTravel;
import java.sql.*;

/**
 * Handling connections to database
 */
public class DatabaseConnect {

    /**
     * Establishes a connection to a local database
     * Executes queries sent in parameters
     * @param script String containing sql query
     */
    public static void databaseConnect(String script) {
        {
            try {
                Connection myConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mt", "root", "MarsTravelPassword");
                Statement myStmt = myConn.createStatement();
                myStmt.executeUpdate(script);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Establishes a connection to a local database
     * Runs a query based on sql script received in parameter
     * @param script Query to be executed
     * @param script1 Selected column to be returned
     * @return String containing info collected from database
     */
    public static String databaseQuery(String script, String script1) {
        String result = "";
        try {
            Connection myConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mt", "root", "MarsTravelPassword");
            Statement myStmt = myConn.createStatement();
            ResultSet myRes = myStmt.executeQuery(script);
            while (myRes.next()) {
                result = myRes.getString(script1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}