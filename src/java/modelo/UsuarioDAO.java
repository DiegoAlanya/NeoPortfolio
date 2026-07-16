package modelo;

import java.sql.*;

public class UsuarioDAO {
    
    public boolean validar(String email, String password) {
        String sql = "SELECT * FROM usuarios WHERE email = ? AND password = ?";
        
        try (Connection conn = ConexionBD.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return true;
            }
            rs.close();
        } catch (SQLException e) {
            System.err.println("Error login: " + e.getMessage());
        }
        return false;
    }
    
    public String obtenerNombre(String email) {
        String sql = "SELECT nombre FROM usuarios WHERE email = ?";
        
        try (Connection conn = ConexionBD.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getString("nombre");
            }
            rs.close();
        } catch (SQLException e) {
            System.err.println("Error: " + e.getMessage());
        }
        return null;
    }
}