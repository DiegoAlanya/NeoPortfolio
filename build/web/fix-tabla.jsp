<%@ page import="java.sql.*" %>
<%
    out.println("<h1>ARREGLANDO TABLA...</h1>");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://tokaido.proxy.rlwy.net:17686/railway", "root", "TyYcNUcOAoPabLfxQNUCEZVqjcIMRZRw"
        );
        Statement stmt = conn.createStatement();
        
        // Agregar columna descripcion si no existe
        stmt.executeUpdate("ALTER TABLE ejercicios ADD COLUMN descripcion TEXT AFTER titulo");
        out.println("<p style='color:green;'>? Columna descripcion agregada</p>");
        
        stmt.close(); conn.close();
        out.println("<h2 style='color:#22c55e;'>? LISTO</h2>");
    } catch (Exception e) {
        out.println("<p style='color:red;'>" + e.getMessage() + "</p>");
    }
%>