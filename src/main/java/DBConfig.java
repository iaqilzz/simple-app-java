

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConfig {
    
    private static final String URL = "jdbc:oracle:thin:@//localhost:1521/freepdb1";
    private static final String USER = "bembanpos";
    private static final String PASSWORD = "bembanpos";

    public static Connection getConnection() throws SQLException {
        try {
            // Load Oracle JDBC Driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("Oracle JDBC Driver not found.");
            throw new SQLException(e);
        }
    }
}
