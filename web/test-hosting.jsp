<%@ page import="java.sql.*" %>
<%
    out.println("<h1>TEST</h1>");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        out.println("<p style='color:green;'>Driver OK</p>");
        
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://tokaido.proxy.rlwy.net:17686/railway?useSSL=false&serverTimezone=UTC",
            "root", "TyYcNUcOAoPabLfxQNUCEZVqjcIMRZRw"
        );
        out.println("<p style='color:green;'>Conexion OK</p>");
        
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM proyectos");
        rs.next();
        out.println("<p style='color:green;'>Proyectos: " + rs.getInt(1) + "</p>");
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>" + e.getMessage() + "</p>");
    }
%>