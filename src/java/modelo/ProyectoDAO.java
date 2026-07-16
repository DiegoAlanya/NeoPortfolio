package modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProyectoDAO {
    
    public List<Proyecto> obtenerTodos() {
        List<Proyecto> lista = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            // Obtener conexión
            conn = ConexionBD.getConexion();
            
            if (conn == null) {
                System.out.println("❌ Conexión es NULL");
                return lista;
            }
            
            System.out.println("✅ Conexión OK, ejecutando consulta...");
            
            // Ejecutar consulta
            String sql = "SELECT * FROM proyectos ORDER BY semana ASC";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            // Recorrer resultados
            while (rs.next()) {
                Proyecto p = new Proyecto();
                p.setId(rs.getInt("id"));
                p.setSemana(rs.getString("semana"));
                p.setTitulo(rs.getString("titulo"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setTecnologia1(rs.getString("tecnologia_1"));
                p.setTecnologia2(rs.getString("tecnologia_2"));
                p.setImagen(rs.getString("imagen"));
                lista.add(p);
            }
            
            System.out.println("✅ Proyectos encontrados: " + lista.size());
            
        } catch (SQLException e) {
            System.out.println("❌ Error SQL: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Cerrar recursos
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
        
        return lista;
    }
    
    public Proyecto obtenerPorSemana(String semana) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = ConexionBD.getConexion();
            if (conn == null) return null;
            
            String sql = "SELECT * FROM proyectos WHERE semana = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, semana);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                Proyecto p = new Proyecto();
                p.setId(rs.getInt("id"));
                p.setSemana(rs.getString("semana"));
                p.setTitulo(rs.getString("titulo"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setTecnologia1(rs.getString("tecnologia_1"));
                p.setTecnologia2(rs.getString("tecnologia_2"));
                p.setImagen(rs.getString("imagen"));
                return p;
            }
            
        } catch (SQLException e) {
            System.out.println("❌ Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
        
        return null;
    }
    
    public int contarProyectos() {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = ConexionBD.getConexion();
            if (conn == null) return 0;
            
            String sql = "SELECT COUNT(*) FROM proyectos";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            System.out.println("❌ Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
        
        return 0;
    }
}