<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String nombre = (String) session.getAttribute("nombre");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DASHBOARD | NEO PORTFOLIO</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;600;700;800;900&family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <div class="login-bg"></div>
    <div class="login-particles"></div>
    
    <div class="dashboard-container">
        <div class="dashboard-header">
            <div class="dashboard-user">
                <div class="dashboard-avatar">☠</div>
                <div>
                    <h2>BIENVENIDO, <%= nombre.toUpperCase() %></h2>
                    <p>HELL SYSTEM ADMIN</p>
                </div>
            </div>
            <a href="cerrar-sesion.jsp" class="dashboard-logout">
                <i class="fas fa-power-off"></i> CERRAR SESIÓN
            </a>
        </div>
        
        <div class="dashboard-cards">
            <a href="trabajos.jsp" class="dashboard-card">
                <i class="fas fa-folder-open"></i>
                <h3>PROYECTOS</h3>
                <p>Gestionar misiones</p>
            </a>
            <a href="index.jsp" class="dashboard-card">
                <i class="fas fa-home"></i>
                <h3>PORTAL</h3>
                <p>Ver sitio web</p>
            </a>
            <a href="contacto.jsp" class="dashboard-card">
                <i class="fas fa-envelope"></i>
                <h3>MENSAJES</h3>
                <p>Ver contactos</p>
            </a>
        </div>
    </div>
    
    <script src="js/login.js"></script>
</body>
</html>