<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String error = "";
    if (request.getMethod().equals("POST")) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        modelo.UsuarioDAO dao = new modelo.UsuarioDAO();
        
        if (dao.validar(email, password)) {
            session.setAttribute("usuario", email);
            session.setAttribute("nombre", dao.obtenerNombre(email));
            response.sendRedirect("dashboard.jsp");
            return;
        } else {
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
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;600;700;800;900&family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <div class="login-bg"></div>
    <div class="login-particles"></div>
    
    <div class="login-container">
        <!-- Logo -->
        <div class="login-logo">
            <div class="login-symbol">☠</div>
            <h1>NEO PORTFOLIO</h1>
            <p>HELL SYSTEM LOGIN</p>
        </div>
        
        <!-- Form -->
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
            <div class="login-error">
                <i class="fas fa-exclamation-triangle"></i> <%= error %>
            </div>
            <% } %>
            
            <button type="submit" class="login-btn">
                <i class="fas fa-skull"></i> INICIAR SESIÓN
            </button>
        </form>
        
        <!-- Back -->
        <a href="index.jsp" class="login-back">
            <i class="fas fa-arrow-left"></i> VOLVER AL PORTAL
        </a>
    </div>
    
    <script src="js/login.js"></script>
</body>
</html>