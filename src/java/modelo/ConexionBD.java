package modelo;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConexionBD {
    
    private static final String HOST = System.getenv("DB_HOST") != null ? System.getenv("DB_HOST") : "localhost";
    private static final String PORT = System.getenv("DB_PORT") != null ? System.getenv("DB_PORT") : "3306";
    private static final String NAME = System.getenv("DB_NAME") != null ? System.getenv("DB_NAME") : "neo_portfolio";
    private static final String USER = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "root";
    private static final String PASS = System.getenv("DB_PASS") != null ? System.getenv("DB_PASS") : "";
    
    private static final String URL = "jdbc:mysql://" + HOST + ":" + PORT + "/" + NAME + "?useSSL=false&serverTimezone=UTC";
    
    public static Connection getConexion() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("✅ Conectado a: " + HOST);
        } catch (Exception e) {
            System.err.println("❌ Error: " + e.getMessage());
        }
        return conn;
    }
}