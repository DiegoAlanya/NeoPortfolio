package modelo;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConexionBD {
    
    private static final String URL = "jdbc:mysql://tokaido.proxy.rlwy.net:17686/railway?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "TyYcNUcOAoPabLfxQNUCEZVqjcIMRZRw";
    
    public static Connection getConexion() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("✅ Conectado a Railway MySQL");
        } catch (Exception e) {
            System.err.println("❌ Error: " + e.getMessage());
        }
        return conn;
    }
}