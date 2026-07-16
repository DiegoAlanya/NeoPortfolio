package modelo;

import java.sql.*;

public class UsuarioDAO {
    
    public boolean validar(String email, String password) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = ConexionBD.getConexion();
            if (conn == null) return false;
            
            String sql = "SELECT * FROM usuarios WHERE email = ? AND password = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();
            
            return rs.next();
            
        } catch (SQLException e) {
            System.err.println("Error login: " + e.getMessage());
            return false;
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }
    
    public String obtenerNombre(String email) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = ConexionBD.getConexion();
            if (conn == null) return null;
            
            String sql = "SELECT nombre FROM usuarios WHERE email = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getString("nombre");
            }
            return null;
            
        } catch (SQLException e) {
            System.err.println("Error: " + e.getMessage());
            return null;
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }
}