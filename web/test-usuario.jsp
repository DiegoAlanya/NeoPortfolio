<%@ page import="java.sql.*" %>
<%
    out.println("<h1>TEST USUARIOS</h1>");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://tokaido.proxy.rlwy.net:17686/railway?useSSL=false&serverTimezone=UTC",
            "root", "TyYcNUcOAoPabLfxQNUCEZVqjcIMRZRw"
        );
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM usuarios");
        
        while (rs.next()) {
            out.println("<p>Nombre: " + rs.getString("nombre") + "</p>");
            out.println("<p>Email: " + rs.getString("email") + "</p>");
            out.println("<p>Password: " + rs.getString("password") + "</p>");
            out.println("<hr>");
        }
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>" + e.getMessage() + "</p>");
    }
%>