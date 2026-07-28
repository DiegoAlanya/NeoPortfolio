<%@ page import="java.sql.*" %>
<%
    out.println("<h1>CONFIGURANDO BD...</h1>");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://tokaido.proxy.rlwy.net:17686/railway", "root", "TyYcNUcOAoPabLfxQNUCEZVqjcIMRZRw"
        );
        Statement stmt = conn.createStatement();
        
        // Eliminar semanas 15 y 16
        stmt.executeUpdate("DELETE FROM proyectos WHERE semana IN ('15','16')");
        out.println("<p style='color:green;'>? Semanas 15 y 16 eliminadas</p>");
        
        // Crear tabla ejercicios
        stmt.executeUpdate("CREATE TABLE IF NOT EXISTS ejercicios (id INT AUTO_INCREMENT PRIMARY KEY, semana VARCHAR(2) NOT NULL, numero INT NOT NULL, titulo VARCHAR(200) NOT NULL)");
        out.println("<p style='color:green;'>? Tabla ejercicios creada</p>");
        
        // Insertar ejercicios
        String[][] datos = {
            {"01","1","Estructura básica HTML5"},{"01","2","Etiquetas semánticas"},{"01","3","Formularios HTML"},
            {"01","4","Tablas en HTML"},{"01","5","Listas ordenadas"},{"01","6","Enlaces y navegación"},
            {"01","7","Imágenes y multimedia"},{"01","8","Metaetiquetas"},{"01","9","Comentarios"},{"01","10","Proyecto: Página personal"},
            {"02","1","Selectores CSS"},{"02","2","Colores y fondos"},{"02","3","Box Model"},
            {"02","4","Tipografía"},{"02","5","Bordes y sombras"},{"02","6","Proyecto: Tarjeta presentación"},
            {"03","1","Flexbox básico"},{"03","2","Flexbox alineación"},{"03","3","CSS Grid fundamentos"},
            {"03","4","CSS Grid áreas"},{"03","5","Layout responsive"},{"03","6","Proyecto: Galería"},
            {"04","1","Variables y tipos"},{"04","2","Funciones y eventos"},{"04","3","Manipulación DOM"},{"04","4","Proyecto: Calculadora"},
            {"05","1","Arrow functions"},{"05","2","Promesas"},{"05","3","Fetch API"},
            {"05","4","LocalStorage"},{"05","5","Módulos ES6"},{"05","6","Proyecto: To-Do List"},
            {"06","1","Clases y objetos"},{"06","2","Herencia"},{"06","3","Proyecto: Sistema estudiantes"},
            {"07","1","ArrayList"},{"07","2","LinkedList"},{"07","3","HashMap"},{"07","4","HashSet"},
            {"07","5","TreeMap"},{"07","6","Iteradores"},{"07","7","Comparator"},{"07","8","Filtrado"},
            {"07","9","Conversión colecciones"},{"07","10","Proyecto: Agenda contactos"},
            {"08","1","Diseño BD"},{"08","2","Proyecto: Esquema tienda"},
            {"09","1","Hola Mundo JSP"},{"09","2","Formulario JSP"},
            {"10","1","Includes JSPF"},{"10","2","Custom Tags"},
            {"11","1","Controlador Servlet"},{"11","2","Vista JSP con modelo"},
        };
        
        for (String[] d : datos) {
            stmt.executeUpdate("INSERT INTO ejercicios (semana, numero, titulo) VALUES ('"+d[0]+"','"+d[1]+"','"+d[2]+"')");
        }
        out.println("<p style='color:green;'>? Ejercicios insertados</p>");
        
        stmt.close();
        conn.close();
        out.println("<h2 style='color:#22c55e;'>? TODO LISTO</h2>");
    } catch (Exception e) {
        out.println("<p style='color:red;'>? " + e.getMessage() + "</p>");
    }
%>