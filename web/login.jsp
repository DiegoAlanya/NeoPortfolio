<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String error = "";
    if (request.getMethod().equals("POST")) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            java.sql.Connection conn = java.sql.DriverManager.getConnection(
                "jdbc:mysql://tokaido.proxy.rlwy.net:17686/railway?useSSL=false&serverTimezone=UTC",
                "root", "TyYcNUcOAoPabLfxQNUCEZVqjcIMRZRw"
            );
            java.sql.PreparedStatement ps = conn.prepareStatement("SELECT * FROM usuarios WHERE email = ? AND password = ?");
            ps.setString(1, email);
            ps.setString(2, password);
            java.sql.ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                String nombre = rs.getString("nombre");
                session.setAttribute("usuario", email);
                session.setAttribute("nombre", nombre);
                rs.close();
                ps.close();
                conn.close();
                response.sendRedirect("dashboard.jsp");
                return;
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            error = "ERROR: " + e.getMessage();
        }
        
        if (error.isEmpty()) {
            error = "ACCESO DENEGADO - CREDENCIALES INVALIDAS";
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LOGIN | NEO PORTFOLIO</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Rajdhani:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <div class="login-bg"></div>
    <div class="login-particles"></div>
    <div class="login-container">
        <div class="login-logo">
            <div class="login-symbol">☠</div>
            <h1>NEO PORTFOLIO</h1>
            <p>HELL SYSTEM LOGIN</p>
        </div>
        <form method="POST" class="login-form">
            <div class="login-input-group">
                <i class="fas fa-user"></i>
                <input type="email" name="email" placeholder="EMAIL" required>
            </div>
            <div class="login-input-group">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" placeholder="PASSWORD" required>
            </div>
            <% if (!error.isEmpty()) { %>
            <div class="login-error"><%= error %></div>
            <% } %>
            <button type="submit" class="login-btn">INICIAR SESIÓN</button>
        </form>
        <a href="index.jsp" class="login-back">VOLVER AL PORTAL</a>
    </div>
    <script src="js/login.js"></script>
</body>
</html>