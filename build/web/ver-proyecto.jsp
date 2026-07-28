<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String weekParam = request.getParameter("week");
    if (weekParam == null || weekParam.isEmpty()) weekParam = "01";
    
    int weekNumber = Integer.parseInt(weekParam);
    String weekFormatted = String.format("%02d", weekNumber);
    
    // Calcular capturas
    int captura1Num = (weekNumber * 2) - 1;
    int captura2Num = weekNumber * 2;
    String captura1 = "imagenes/capturas/captura_" + captura1Num + ".png";
    String captura2 = "imagenes/capturas/captura_" + captura2Num + ".png";
    
    // Obtener datos desde Railway
    String projectTitle = "Proyecto", projectDescription = "", tech1 = "", tech2 = "";
    String nextProjectTitle = "", prevProjectTitle = "";
    int totalSemanas = 14;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://tokaido.proxy.rlwy.net:17686/railway?useSSL=false&serverTimezone=UTC",
            "root", "TyYcNUcOAoPabLfxQNUCEZVqjcIMRZRw"
        );
        
        // Obtener proyecto actual
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM proyectos WHERE semana = ?");
        ps.setString(1, weekFormatted);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            projectTitle = rs.getString("titulo");
            projectDescription = rs.getString("descripcion");
            tech1 = rs.getString("tecnologia_1");
            tech2 = rs.getString("tecnologia_2");
        }
        rs.close(); ps.close();
        
        // Obtener títulos de navegación
        int nextWeek = weekNumber + 1;
        int prevWeek = weekNumber - 1;
        
        if (prevWeek >= 1) {
            ps = conn.prepareStatement("SELECT titulo FROM proyectos WHERE semana = ?");
            ps.setString(1, String.format("%02d", prevWeek));
            rs = ps.executeQuery();
            if (rs.next()) prevProjectTitle = rs.getString("titulo");
            rs.close(); ps.close();
        }
        
        if (nextWeek <= totalSemanas) {
            ps = conn.prepareStatement("SELECT titulo FROM proyectos WHERE semana = ?");
            ps.setString(1, String.format("%02d", nextWeek));
            rs = ps.executeQuery();
            if (rs.next()) nextProjectTitle = rs.getString("titulo");
            rs.close(); ps.close();
        }
        
        conn.close();
    } catch (Exception e) {
        projectDescription = "Error al cargar datos.";
    }
    
    // Navegación
    int nextWeek = weekNumber + 1;
    int prevWeek = weekNumber - 1;
    String nextWeekStr = String.format("%02d", nextWeek);
    String prevWeekStr = String.format("%02d", prevWeek);
    
    // Mostrar botón EJECUTAR (semanas 01-11)
    boolean mostrarEjecutar = (weekNumber >= 1 && weekNumber <= 11);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WEEK_<%= weekFormatted %> - <%= projectTitle %> | NEO PORTFOLIO</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;600;700;800;900&family=Rajdhani:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="stylesheet" href="css/ver-proyecto.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .vp-btn-ejecutar {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            padding: 17px 35px;
            font-family: 'Orbitron', sans-serif;
            font-size: 13px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 4px;
            text-decoration: none;
            transition: all 0.45s cubic-bezier(0.4, 0, 0.2, 1);
            background: linear-gradient(135deg, #166534, #22c55e);
            color: #fff;
            border: 1px solid #22c55e;
            box-shadow: 0 0 25px rgba(34,197,94,0.3);
            min-width: 200px;
            position: relative;
            overflow: hidden;
            animation: ejecutarPulse 2s infinite;
        }
        
        .vp-btn-ejecutar::before {
            content: '';
            position: absolute;
            top: 0; left: -100%;
            width: 100%; height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s ease;
        }
        
        .vp-btn-ejecutar:hover {
            background: linear-gradient(135deg, #22c55e, #4ade80);
            box-shadow: 0 0 45px rgba(34,197,94,0.6), 0 10px 30px rgba(0,0,0,0.4);
            transform: translateY(-3px);
            border-color: #4ade80;
        }
        
        .vp-btn-ejecutar:hover::before { left: 100%; }
        
        @keyframes ejecutarPulse {
            0%, 100% { box-shadow: 0 0 25px rgba(34,197,94,0.3); }
            50% { box-shadow: 0 0 50px rgba(34,197,94,0.6); }
        }
    </style>
</head>
<body>
    <div class="demon-runes"></div>
    <div class="vignette"></div>
    <div class="noise"></div>
    <canvas id="particleCanvas"></canvas>
    
    <%@ include file="includes/header.jsp" %>
    
    <main class="vp-main">
        
        <div class="vp-top-bar">
            <a href="trabajos.jsp" class="vp-back-btn">
                <i class="fas fa-arrow-left"></i>
                <span>VOLVER A MISIONES</span>
            </a>
            
            <div class="vp-week-navigation">
                <% if (prevWeek >= 1) { %>
                <a href="ver-proyecto.jsp?week=<%= prevWeekStr %>" class="vp-nav-btn">
                    <i class="fas fa-chevron-left"></i> WEEK_<%= prevWeekStr %>
                </a>
                <% } %>
                <span class="vp-current-week">WEEK_<%= weekFormatted %></span>
                <% if (nextWeek <= totalSemanas) { %>
                <a href="ver-proyecto.jsp?week=<%= nextWeekStr %>" class="vp-nav-btn">
                    WEEK_<%= nextWeekStr %> <i class="fas fa-chevron-right"></i>
                </a>
                <% } %>
            </div>
        </div>
        
        <article class="vp-project-card">
            <div class="vp-week-badge">
                <span class="vp-badge-icon">☠</span>
                WEEK_<%= weekFormatted %> &ndash; MISSION COMPLETE
                <span class="vp-badge-icon">☠</span>
            </div>
            
            <h1 class="vp-project-title"><%= projectTitle.toUpperCase() %></h1>
            <p class="vp-project-description"><%= projectDescription %></p>
            
            <div class="vp-divider">
                <span class="vp-divider-line"></span>
                <i class="fas fa-skull vp-divider-icon"></i>
                <span class="vp-divider-line"></span>
            </div>
            
            <div class="vp-stack-section">
                <h3 class="vp-stack-title"><i class="fas fa-microchip"></i> STACK UTILIZADO</h3>
                <div class="vp-stack-tags">
                    <span class="vp-tag"><i class="fas fa-code"></i> <%= tech1 %></span>
                    <span class="vp-tag"><i class="fas fa-code"></i> <%= tech2 %></span>
                </div>
            </div>
            
            <div class="vp-captures-section">
                <h3 class="vp-captures-title"><i class="fas fa-images"></i> INFOGRAFIAS <i class="fas fa-chevron-right vp-chevron"></i></h3>
                <div class="vp-captures-grid">
                    <div class="vp-capture-card">
                        <div class="vp-capture-img-container">
                            <img src="<%= captura1 %>?v=<%= System.currentTimeMillis() %>" alt="Captura 1" class="vp-capture-img" onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22800%22 height=%22500%22%3E%3Crect fill=%22%23111%22 width=%22800%22 height=%22500%22/%3E%3Ctext fill=%22%23dc2626%22 font-family=%22monospace%22 font-size=%2230%22 x=%22400%22 y=%22250%22 text-anchor=%22middle%22%3EWEEK <%= weekFormatted %>%3C/text%3E%3C/svg%3E';">
                            <div class="vp-capture-overlay"><i class="fas fa-search-plus"></i></div>
                            <div class="vp-capture-number">01</div>
                        </div>
                        <p class="vp-capture-label"><i class="fas fa-image"></i> INFOGRAFIA_<%= captura1Num %>.PNG</p>
                    </div>
                    <div class="vp-capture-card">
                        <div class="vp-capture-img-container">
                            <img src="<%= captura2 %>?v=<%= System.currentTimeMillis() %>" alt="Captura 2" class="vp-capture-img" onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22800%22 height=%22500%22%3E%3Crect fill=%22%23111%22 width=%22800%22 height=%22500%22/%3E%3Ctext fill=%22%23dc2626%22 font-family=%22monospace%22 font-size=%2230%22 x=%22400%22 y=%22250%22 text-anchor=%22middle%22%3EWEEK <%= weekFormatted %>%3C/text%3E%3C/svg%3E';">
                            <div class="vp-capture-overlay"><i class="fas fa-search-plus"></i></div>
                            <div class="vp-capture-number">02</div>
                        </div>
                        <p class="vp-capture-label"><i class="fas fa-image"></i> INFOGRAFIA_<%= captura2Num %>.PNG</p>
                    </div>
                </div>
            </div>
            
            <div class="vp-actions">
                <a href="ver-pdf.jsp?week=<%= weekFormatted %>" class="vp-btn vp-btn-primary">
                    <i class="fas fa-file-pdf"></i> VER DEMO (PDF)
                </a>
                
                <% if (mostrarEjecutar) { %>
                <a href="ejercicios.jsp?week=<%= weekFormatted %>" class="vp-btn-ejecutar">
                    <i class="fas fa-play"></i> EJECUTAR
                </a>
                <% } %>
                
                <a href="trabajos.jsp" class="vp-btn vp-btn-secondary">
                    <i class="fas fa-arrow-left"></i> REGRESAR
                </a>
            </div>
            
        </article>
        
        <div class="vp-bottom-navigation">
            <% if (prevWeek >= 1) { %>
            <a href="ver-proyecto.jsp?week=<%= prevWeekStr %>" class="vp-bottom-nav-btn vp-prev">
                <i class="fas fa-arrow-left"></i>
                <div>
                    <span class="vp-nav-label">MISIÓN ANTERIOR</span>
                    <span class="vp-nav-title">WEEK_<%= prevWeekStr %> &ndash; <%= prevProjectTitle %></span>
                </div>
            </a>
            <% } else { %><div></div><% } %>
            
            <% if (nextWeek <= totalSemanas) { %>
            <a href="ver-proyecto.jsp?week=<%= nextWeekStr %>" class="vp-bottom-nav-btn vp-next">
                <div>
                    <span class="vp-nav-label">SIGUIENTE MISIÓN</span>
                    <span class="vp-nav-title">WEEK_<%= nextWeekStr %> &ndash; <%= nextProjectTitle %></span>
                </div>
                <i class="fas fa-arrow-right"></i>
            </a>
            <% } %>
        </div>
        
    </main>
    
    <%@ include file="includes/footer.jsp" %>
    
    <script src="js/particles.js"></script>
    <script src="js/main.js"></script>
    <script src="js/scroll.js"></script>
    <script src="js/animations.js"></script>
    <script src="js/ver-proyecto.js"></script>
</body>
</html>