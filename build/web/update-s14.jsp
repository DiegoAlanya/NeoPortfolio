<%@ page import="java.sql.*" %>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://tokaido.proxy.rlwy.net:17686/railway", "root", "TyYcNUcOAoPabLfxQNUCEZVqjcIMRZRw"
        );
        Statement stmt = conn.createStatement();
        stmt.executeUpdate("UPDATE proyectos SET titulo='DOMINIO DE SUKUNA', descripcion='SISTEMA DE CONTROL DE ASISTENCIA. Domina el nivel 14 de entrenamiento hechicero. El Rey de las Maldiciones. Proyecto final donde se demuestra el dominio absoluto de todas las tecnologías aprendidas. Expansión de dominio: Desarrollo Web Completo.', tecnologia_1='SUKUNA', tecnologia_2='DOMINIO' WHERE semana='14'");
        out.println("<p style='color:green;'>? Actualizado</p>");
        stmt.close(); conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>? " + e.getMessage() + "</p>");
    }
%>