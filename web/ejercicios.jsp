<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String weekParam = request.getParameter("week");
    if (weekParam == null || weekParam.isEmpty()) weekParam = "01";
    
    List<String[]> ejercicios = new ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://tokaido.proxy.rlwy.net:17686/railway?useSSL=false&serverTimezone=UTC",
            "root", "TyYcNUcOAoPabLfxQNUCEZVqjcIMRZRw"
        );
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM ejercicios WHERE semana = ? ORDER BY numero ASC");
        ps.setString(1, weekParam);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            ejercicios.add(new String[]{rs.getString("numero"), rs.getString("titulo"), rs.getString("descripcion")});
        }
        rs.close(); ps.close(); conn.close();
    } catch (Exception e) {}
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>EJERCICIOS SEMANA <%= weekParam %> | NEO PORTFOLIO</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/cards.css">
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .ejercicios-container { max-width: 900px; margin: 120px auto 60px; padding: 0 20px; }
        .ejercicio-card { 
            background: #111; border: 1px solid rgba(34,197,94,0.3); padding: 25px; 
            margin-bottom: 15px; display: flex; align-items: center; gap: 20px; 
            transition: all 0.3s; cursor: pointer; 
        }
        .ejercicio-card:hover { 
            border-color: #22c55e; box-shadow: 0 0 30px rgba(34,197,94,0.25); 
            transform: translateX(8px); background: #1a1a1a;
        }
        .ejercicio-card:active { transform: scale(0.98); }
        .ejercicio-numero { 
            width: 55px; height: 55px; background: linear-gradient(135deg, #166534, #22c55e); 
            color: #fff; font-family: 'Orbitron', sans-serif; font-size: 22px; font-weight: 900; 
            display: flex; align-items: center; justify-content: center; flex-shrink: 0;
            box-shadow: 0 0 20px rgba(34,197,94,0.3);
        }
        .ejercicio-info h3 { 
            font-family: 'Orbitron', sans-serif; font-size: 16px; color: #fff; 
            margin: 0 0 5px 0; letter-spacing: 2px; 
        }
        .ejercicio-info p { 
            font-family: 'Rajdhani', sans-serif; font-size: 14px; color: #9ca3af; margin: 0; 
        }
        .ejercicio-flecha { 
            margin-left: auto; color: #22c55e; font-size: 20px; 
            transition: transform 0.3s; 
        }
        .ejercicio-card:hover .ejercicio-flecha { transform: translateX(5px); }
        .back-btn { 
            display: inline-block; padding: 12px 25px; border: 1px solid #dc2626; 
            color: #dc2626; text-decoration: none; font-family: 'Orbitron', sans-serif; 
            font-size: 12px; letter-spacing: 2px; margin-bottom: 30px; transition: all 0.3s; 
        }
        .back-btn:hover { background: rgba(220,38,38,0.1); box-shadow: 0 0 20px rgba(220,38,38,0.3); }
        .titulo-semana { 
            font-family: 'Orbitron', sans-serif; color: #22c55e; letter-spacing: 5px; 
            margin-bottom: 10px; font-size: 28px; 
        }
        .subtitulo-semana { 
            font-family: 'Rajdhani', sans-serif; color: #6b7280; font-size: 14px; 
            letter-spacing: 3px; margin-bottom: 30px; 
        }
        .contador { 
            font-family: 'Orbitron', sans-serif; color: #6b7280; font-size: 12px; 
            letter-spacing: 2px; margin-bottom: 20px; 
        }
    </style>
</head>
<body>
    <div class="demon-runes"></div>
    <div class="vignette"></div>
    <div class="noise"></div>
    <canvas id="particleCanvas"></canvas>
    <%@ include file="includes/header.jsp" %>
    
    <div class="ejercicios-container">
        <a href="trabajos.jsp" class="back-btn"><i class="fas fa-arrow-left"></i> VOLVER A MISIONES</a>
        
        <h1 class="titulo-semana">☠ EJERCICIOS - SEMANA <%= weekParam %></h1>
        <p class="subtitulo-semana">HELL SYSTEM TRAINING MODULE</p>
        <p class="contador"><i class="fas fa-code"></i> <%= ejercicios.size() %> EJERCICIOS DISPONIBLES</p>
        
        <% for (String[] e : ejercicios) { %>
        <div class="ejercicio-card" onclick="location.href='resultado.jsp?week=<%= weekParam %>&ej=<%= e[0] %>'">
            <div class="ejercicio-numero"><%= e[0] %></div>
            <div class="ejercicio-info">
                <h3><%= e[1] %></h3>
                <p><%= e[2] %></p>
            </div>
            <div class="ejercicio-flecha">
                <i class="fas fa-chevron-right"></i>
            </div>
        </div>
        <% } %>
        
        <% if (ejercicios.isEmpty()) { %>
        <div style="text-align:center;padding:60px;color:#dc2626;font-family:'Orbitron',sans-serif;">
            <i class="fas fa-exclamation-triangle" style="font-size:50px;display:block;margin-bottom:20px;"></i>
            <h2>NO HAY EJERCICIOS</h2>
            <p style="color:#9ca3af;">Esta semana no tiene ejercicios asignados</p>
        </div>
        <% } %>
    </div>
    
    <%@ include file="includes/footer.jsp" %>
    <script src="js/particles.js"></script>
</body>
</html>