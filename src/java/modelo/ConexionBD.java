package modelo;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConexionBD {
    
    private static final String URL = "jdbc:mysql://sql10833156.freesqldatabase.com:3306/sql10833156?useSSL=false&serverTimezone=UTC";
    private static final String USER = "sql10833156";
    private static final String PASS = "Tw4sJ3GlXy";
    
    public static Connection getConexion() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("✅ Conectado a hosting MySQL");
        } catch (Exception e) {
            System.err.println("❌ Error: " + e.getMessage());
        }
        return conn;
    }
}