<%@ page import="java.sql.*" %>
<%
    out.println("<h1>ACTUALIZANDO SEMANA 14...</h1>");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://tokaido.proxy.rlwy.net:17686/railway", "root", "TyYcNUcOAoPabLfxQNUCEZVqjcIMRZRw"
        );
        Statement stmt = conn.createStatement();
        
        stmt.executeUpdate("UPDATE proyectos SET titulo='SANTUARIO MALÉVOLO', descripcion='Fukuma Mizushi (?????). Expansión territorial dominada por Sukuna. SISTEMA DE CONTROL DE ASISTENCIA. Domina el nivel 14 de entrenamiento hechicero. El santuario se despliega absorbiendo todo a su paso con energía maldita absoluta.', tecnologia_1='FUKUMA', tecnologia_2='MIZUSHI' WHERE semana='14'");
        
        out.println("<p style='color:green;'>? Semana 14 actualizada: SANTUARIO MALÉVOLO</p>");
        out.println("<p style='color:#f59e0b;'>? ????? - FUKUMA MIZUSHI</p>");
        
        stmt.close(); conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>? " + e.getMessage() + "</p>");
    }
%>