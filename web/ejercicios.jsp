<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String weekParam = request.getParameter("week");
    if (weekParam == null || weekParam.isEmpty()) weekParam = "01";
    
    List<Map<String, String>> ejercicios = new ArrayList<>();
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
            Map<String, String> e = new HashMap<>();
            e.put("numero", rs.getString("numero"));
            e.put("titulo", rs.getString("titulo"));
            ejercicios.add(e);
        }
        rs.close(); ps.close(); conn.close();
    } catch (Exception e) {}
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>EJERCICIOS WEEK <%= weekParam %> | NEO PORTFOLIO</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/cards.css">
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .ejercicios-container {
            max-width: 900px;
            margin: 120px auto 60px;
            padding: 0 20px;
        }
        .ejercicio-card {
            background: #111;
            border: 1px solid rgba(34,197,94,0.3);
            padding: 25px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 20px;
            transition: all 0.3s;
        }
        .ejercicio-card:hover {
            border-color: #22c55e;
            box-shadow: 0 0 25px rgba(34,197,94,0.2);
            transform: translateX(5px);
        }
        .ejercicio-numero {
            width: 50px;
            height: 50px;
            background: #22c55e;
            color: #000;
            font-family: 'Orbitron', sans-serif;
            font-size: 20px;
            font-weight: 900;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .ejercicio-titulo {
            font-family: 'Rajdhani', sans-serif;
            font-size: 18px;
            color: #fff;
        }
        .back-btn {
            display: inline-block;
            padding: 12px 25px;
            border: 1px solid #dc2626;
            color: #dc2626;
            text-decoration: none;
            font-family: 'Orbitron', sans-serif;
            font-size: 12px;
            letter-spacing: 2px;
            margin-bottom: 30px;
            transition: all 0.3s;
        }
        .back-btn:hover {
            background: rgba(220,38,38,0.1);
            box-shadow: 0 0 20px rgba(220,38,38,0.3);
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
        <h1 style="font-family:'Orbitron',sans-serif;color:#22c55e;letter-spacing:5px;margin-bottom:30px;">
            ☠ EJERCICIOS - WEEK <%= weekParam %>
        </h1>
        
        <% for (Map<String, String> e : ejercicios) { %>
        <div class="ejercicio-card">
            <div class="ejercicio-numero"><%= e.get("numero") %></div>
            <div class="ejercicio-titulo"><%= e.get("titulo") %></div>
        </div>
        <% } %>
    </div>
    
    <%@ include file="includes/footer.jsp" %>
    <script src="js/particles.js"></script>
</body>
</html>