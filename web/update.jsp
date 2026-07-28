<%@ page import="java.sql.*" %>
<%
    out.println("<h1>ACTUALIZANDO...</h1>");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://tokaido.proxy.rlwy.net:17686/railway", "root", "TyYcNUcOAoPabLfxQNUCEZVqjcIMRZRw"
        );
        Statement stmt = conn.createStatement();
        
        String[][] datos = {
            {"01","Semana 1","JAVA","TOMCAT"},
            {"02","Semana 2","JAVA","NETBEANS"},
            {"03","Semana 3","JAVA","TOMCAT"},
            {"04","Semana 4","JAVA","NETBEANS"},
            {"05","Semana 5","JAVA","TOMCAT"},
            {"06","Semana 6","JAVA","NETBEANS"},
            {"07","Semana 7","JAVA","TOMCAT"},
            {"08","Semana 8","JAVA","NETBEANS"},
            {"09","Semana 9","JAVA","TOMCAT"},
            {"10","Semana 10","JAVA","NETBEANS"},
            {"11","Semana 11","JAVA","TOMCAT"},
            {"12","Semana 12","JAVA","NETBEANS"},
            {"13","Semana 13","JAVA","TOMCAT"},
            {"14","Semana 14","JAVA","NETBEANS"},
        };
        
        for (String[] d : datos) {
            stmt.executeUpdate("UPDATE proyectos SET titulo='"+d[1]+"', tecnologia_1='"+d[2]+"', tecnologia_2='"+d[3]+"' WHERE semana='"+d[0]+"'");
            out.println("<p style='color:green;'>? "+d[0]+" ? "+d[1]+"</p>");
        }
        
        stmt.close(); conn.close();
        out.println("<h2 style='color:#22c55e;'>? TODO ACTUALIZADO</h2>");
    } catch (Exception e) {
        out.println("<p style='color:red;'>? "+e.getMessage()+"</p>");
    }
%>