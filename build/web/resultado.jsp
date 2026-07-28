<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String week = request.getParameter("week");
    String ej = request.getParameter("ej");
    if (week == null) week = "01";
    if (ej == null) ej = "1";
    
    // Obtener datos del ejercicio
    String titulo = "", descripcion = "";
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://tokaido.proxy.rlwy.net:17686/railway?useSSL=false&serverTimezone=UTC",
            "root", "TyYcNUcOAoPabLfxQNUCEZVqjcIMRZRw"
        );
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM ejercicios WHERE semana = ? AND numero = ?");
        ps.setString(1, week);
        ps.setString(2, ej);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            titulo = rs.getString("titulo");
            descripcion = rs.getString("descripcion");
        }
        rs.close(); ps.close(); conn.close();
    } catch (Exception e) {}
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title><%= titulo %> | NEO PORTFOLIO</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .resultado-container { max-width: 900px; margin: 120px auto 60px; padding: 0 20px; }
        .resultado-card { background: #111; border: 1px solid rgba(34,197,94,0.3); padding: 40px; }
        .resultado-card h1 { font-family: 'Orbitron', sans-serif; color: #22c55e; letter-spacing: 3px; }
        .resultado-card p { font-family: 'Rajdhani', sans-serif; color: #9ca3af; font-size: 16px; }
        .codigo-box { background: #0a0a0a; border: 1px solid #333; padding: 20px; margin: 20px 0; font-family: 'Courier New', monospace; color: #fff; white-space: pre-wrap; }
        .resultado-box { background: #0a0a0a; border: 1px solid #22c55e; padding: 20px; margin: 20px 0; font-family: 'Courier New', monospace; color: #22c55e; }
        .back-btn { display: inline-block; padding: 12px 25px; border: 1px solid #dc2626; color: #dc2626; text-decoration: none; font-family: 'Orbitron', sans-serif; font-size: 12px; letter-spacing: 2px; margin-bottom: 30px; transition: all 0.3s; }
        .back-btn:hover { background: rgba(220,38,38,0.1); box-shadow: 0 0 20px rgba(220,38,38,0.3); }
    </style>
</head>
<body>
    <div class="demon-runes"></div>
    <div class="vignette"></div>
    <div class="noise"></div>
    <canvas id="particleCanvas"></canvas>
    <%@ include file="includes/header.jsp" %>
    
    <div class="resultado-container">
        <a href="ejercicios.jsp?week=<%= week %>" class="back-btn"><i class="fas fa-arrow-left"></i> VOLVER A EJERCICIOS</a>
        
        <div class="resultado-card">
            <h1>☠ <%= titulo %></h1>
            <p><%= descripcion %></p>
            
            <h3 style="font-family:'Orbitron',sans-serif;color:#fff;letter-spacing:2px;">CÓDIGO JAVA</h3>
            <div class="codigo-box" id="codigo">Cargando...</div>
            
            <h3 style="font-family:'Orbitron',sans-serif;color:#22c55e;letter-spacing:2px;">RESULTADO</h3>
            <div class="resultado-box" id="resultado">Cargando...</div>
        </div>
    </div>
    
    <%@ include file="includes/footer.jsp" %>
    <script src="js/particles.js"></script>
    <script>
        // Cargar ejercicio según semana y número
        const week = '<%= week %>';
        const ej = '<%= ej %>';
        cargarEjercicio(week, ej);
        
        function cargarEjercicio(w, e) {
            // Aquí se cargarán los códigos y resultados
            const codigos = {
                '01_1': { codigo: 'public class Rectangulo {\n    public static void main(String[] args) {\n        double base = 10;\n        double altura = 5;\n        double area = base * altura;\n        double perimetro = 2 * (base + altura);\n        System.out.println("Base: " + base);\n        System.out.println("Altura: " + altura);\n        System.out.println("Área: " + area);\n        System.out.println("Perímetro: " + perimetro);\n    }\n}', resultado: 'Base: 10.0\nAltura: 5.0\nÁrea: 50.0\nPerímetro: 30.0' }
            };
            
            const key = w + '_' + e;
            if (codigos[key]) {
                document.getElementById('codigo').textContent = codigos[key].codigo;
                document.getElementById('resultado').textContent = codigos[key].resultado;
            } else {
                document.getElementById('codigo').textContent = '// Código en desarrollo';
                document.getElementById('resultado').textContent = 'Resultado próximamente...';
            }
        }
    </script>
</body>
</html>