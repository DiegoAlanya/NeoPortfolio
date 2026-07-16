package modelo;

import java.sql.*;

public class UsuarioDAO {
    
    private static final String HOST = System.getenv("DB_HOST") != null ? System.getenv("DB_HOST") : "tokaido.proxy.rlwy.net";
    private static final String PORT = System.getenv("DB_PORT") != null ? System.getenv("DB_PORT") : "17686";
    private static final String NAME = System.getenv("DB_NAME") != null ? System.getenv("DB_NAME") : "railway";
    private static final String USER = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "root";
    private static final String PASS = System.getenv("DB_PASS") != null ? System.getenv("DB_PASS") : "TyYcNUcOAoPabLfxQNUCEZVqjcIMRZRw";
    
    private static final String URL = "jdbc:mysql://" + HOST + ":" + PORT + "/" + NAME + "?useSSL=false&serverTimezone=UTC";
    
    public boolean validar(String email, String password) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASS);
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM usuarios WHERE email = ? AND password = ?");
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            boolean ok = rs.next();
            rs.close();
            ps.close();
            conn.close();
            return ok;
        } catch (Exception e) {
            System.err.println("❌ Error: " + e.getMessage());
            return false;
        }
    }
    
    public String obtenerNombre(String email) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASS);
            PreparedStatement ps = conn.prepareStatement("SELECT nombre FROM usuarios WHERE email = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            String nombre = null;
            if (rs.next()) {
                nombre = rs.getString("nombre");
            }
            rs.close();
            ps.close();
            conn.close();
            return nombre;
        } catch (Exception e) {
            System.err.println("❌ Error: " + e.getMessage());
            return null;
        }
    }
}