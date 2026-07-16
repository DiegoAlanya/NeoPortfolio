<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Verificar si hay sesión activa
    String usuarioSesion = (String) session.getAttribute("usuario");
    boolean estaLogueado = (usuarioSesion != null);
%>
<header class="neo-header">
    <div class="header-container">
        <!-- Logo -->
        <a href="index.jsp" class="logo">
            <div class="logo-symbol"></div>
            <span class="logo-text">NEO PORTFOLIO</span>
        </a>
        
        <!-- Navigation -->
        <nav class="neo-nav">
            <a href="index.jsp" class="nav-link">INICIO</a>
            <a href="presentacion.jsp" class="nav-link">PRESENTACIÓN</a>
            <a href="trabajos.jsp" class="nav-link">MIS TRABAJOS</a>
            <a href="contacto.jsp" class="nav-link">CONTACTO</a>
            
            <% if (estaLogueado) { %>
            <!-- Si está logueado, mostrar DASHBOARD -->
            <a href="dashboard.jsp" class="nav-link" style="color: #22c55e;">
                ☠ DASHBOARD
            </a>
            <a href="cerrar-sesion.jsp" class="nav-link" style="color: #dc2626;">
                <i class="fas fa-power-off"></i> SALIR
            </a>
            <% } else { %>
            <!-- Si no está logueado, mostrar LOGIN -->
            <a href="login.jsp" class="nav-link" style="color: #dc2626;">
                ☠ LOGIN
            </a>
            <% } %>
        </nav>
        
        <!-- System Status -->
        <div class="system-status">
            <div class="status-dot"></div>
            <span>ONLINE</span>
        </div>
        
        <!-- Mobile Toggle -->
        <div class="menu-toggle">
            <span></span>
            <span></span>
            <span></span>
        </div>
    </div>
</header>