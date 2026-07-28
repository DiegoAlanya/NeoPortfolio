<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    List<Map<String, String>> proyectos = new ArrayList<>();
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://tokaido.proxy.rlwy.net:17686/railway?useSSL=false&serverTimezone=UTC",
            "root", "TyYcNUcOAoPabLfxQNUCEZVqjcIMRZRw"
        );
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM proyectos ORDER BY semana ASC");
        
        while (rs.next()) {
            Map<String, String> proyecto = new HashMap<>();
            proyecto.put("semana", rs.getString("semana"));
            proyecto.put("titulo", rs.getString("titulo"));
            proyecto.put("descripcion", rs.getString("descripcion"));
            proyecto.put("tecnologia_1", rs.getString("tecnologia_1"));
            proyecto.put("tecnologia_2", rs.getString("tecnologia_2"));
            proyectos.add(proyecto);
        }
    } catch (Exception e) {
        System.out.println("Error: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MISSIONS LOG | NEO PORTFOLIO</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/cards.css">
    <link rel="stylesheet" href="css/skills.css">
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        /* Estilos para los botones en la tarjeta */
        .card-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 15px;
        }
        
        .card-btn-ejecutar {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 22px;
            background: linear-gradient(135deg, #166534, #22c55e);
            border: 1px solid #22c55e;
            color: #fff;
            font-family: 'Teko', sans-serif;
            font-size: 16px;
            text-transform: uppercase;
            letter-spacing: 3px;
            text-decoration: none;
            transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
            position: relative;
            overflow: hidden;
            clip-path: polygon(8px 0, 100% 0, calc(100% - 8px) 100%, 0 100%);
            box-shadow: 0 0 20px rgba(34,197,94,0.3);
        }
        
        .card-btn-ejecutar::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s ease;
        }
        
        .card-btn-ejecutar:hover {
            background: linear-gradient(135deg, #22c55e, #4ade80);
            box-shadow: 0 0 35px rgba(34,197,94,0.6), 0 10px 30px rgba(0,0,0,0.4);
            transform: translateY(-3px);
            border-color: #4ade80;
        }
        
        .card-btn-ejecutar:hover::before {
            left: 100%;
        }
        
        .card-btn-ejecutar i {
            font-size: 14px;
            transition: transform 0.3s ease;
        }
        
        .card-btn-ejecutar:hover i {
            transform: translateX(3px);
        }
        
        /* Animación de pulso para el botón ejecutar */
        @keyframes ejecutarPulse {
            0%, 100% { box-shadow: 0 0 20px rgba(34,197,94,0.3); }
            50% { box-shadow: 0 0 40px rgba(34,197,94,0.6); }
        }
        
        .card-btn-ejecutar {
            animation: ejecutarPulse 2s infinite;
        }
        
        /* Responsive */
        @media (max-width: 480px) {
            .card-actions {
                flex-direction: column;
            }
            .card-actions a {
                width: 100%;
                justify-content: center;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <div class="demon-runes"></div>
    <div class="vignette"></div>
    <div class="noise"></div>
    <canvas id="particleCanvas"></canvas>
    
    <%@ include file="includes/header.jsp" %>
    
    <section class="cards-section" style="padding-top: 120px;">
        <div class="section-title-container">
            <div class="section-badge"><i class="fas fa-database"></i> [ MISSIONS_LOG ]</div>
            <h1 class="section-title">MIS TRABAJOS</h1>
            <div class="section-subtitle">▲ <%= proyectos.size() %> WEEKS OF DEVELOPMENT ▲</div>
        </div>
        
        <div class="cards-grid">
            <%
            if (proyectos.isEmpty()) {
            %>
            <div style="grid-column:1/-1;text-align:center;padding:60px;color:#dc2626;font-family:'Orbitron',sans-serif;">
                <i class="fas fa-exclamation-triangle" style="font-size:50px;display:block;margin-bottom:20px;"></i>
                <h2>NO SE ENCONTRARON PROYECTOS</h2>
                <p style="color:#9ca3af;">La base de datos está vacía o no se pudo conectar</p>
            </div>
            <%
            } else {
                for (Map<String, String> p : proyectos) {
                    String weekNum = p.get("semana");
                    String title = p.get("titulo");
                    String description = p.get("descripcion");
                    String tech1 = p.get("tecnologia_1");
                    String tech2 = p.get("tecnologia_2");
                    
                    // Determinar si mostrar botón EJECUTAR (semanas 01-11)
                    int weekInt = Integer.parseInt(weekNum);
                    boolean mostrarEjecutar = (weekInt >= 1 && weekInt <= 11);
            %>
            <div class="blood-card">
                <div class="card-image-container">
                    <img src="imagenes/proyectos/week<%= weekNum %>.jpg" alt="<%= title %>" onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22600%22 height=%22400%22%3E%3Crect fill=%22%23111%22 width=%22600%22 height=%22400%22/%3E%3Ctext fill=%22%23dc2626%22 font-family=%22monospace%22 font-size=%2230%22 x=%22300%22 y=%22200%22 text-anchor=%22middle%22%3EWEEK <%= weekNum %>%3C/text%3E%3C/svg%3E'">
                    <div class="card-image-overlay"></div>
                    <div class="card-particles" id="particles-<%= weekNum %>"></div>
                    <div class="card-week-badge">WEEK_<%= weekNum %></div>
                    <div class="card-week-number"><%= weekNum %></div>
                </div>
                <div class="card-content">
                    <h3 class="card-title"><%= title %></h3>
                    <p class="card-description"><%= description %></p>
                    <div class="card-technologies">
                        <span class="tech-tag"><%= tech1 %></span>
                        <span class="tech-tag"><%= tech2 %></span>
                    </div>
                    
                    <!-- BOTONES -->
                    <div class="card-actions">
                        <a href="ver-proyecto.jsp?week=<%= weekNum %>" class="card-button">
                            VER PROYECTO <i class="fas fa-arrow-right" style="margin-left:8px;"></i>
                        </a>
                        
                        <% if (mostrarEjecutar) { %>
                        <a href="ejercicios.jsp?week=<%= weekNum %>" class="card-btn-ejecutar">
                            <i class="fas fa-play"></i> EJECUTAR
                        </a>
                        <% } %>
                    </div>
                </div>
            </div>
            <% }} %>
        </div>
    </section>
    
    <%@ include file="includes/footer.jsp" %>
    
    <script src="js/particles.js"></script>
    <script src="js/main.js"></script>
    <script src="js/scroll.js"></script>
    <script src="js/animations.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            document.querySelectorAll('.blood-card').forEach(card => {
                card.addEventListener('mouseenter', () => {
                    const container = card.querySelector('.card-particles');
                    if (container) {
                        for (let i = 0; i < 20; i++) {
                            const particle = document.createElement('div');
                            particle.style.cssText = 'position:absolute;width:'+(Math.random()*5+2)+'px;height:'+(Math.random()*5+2)+'px;background:rgba(255,0,0,'+(Math.random()*0.5+0.3)+');border-radius:50%;left:'+(Math.random()*100)+'%;top:'+(Math.random()*100)+'%;box-shadow:0 0 '+(Math.random()*20+10)+'px rgba(255,0,0,0.8);animation:floatParticle '+(Math.random()*3+1)+'s ease-in-out infinite;';
                            container.appendChild(particle);
                            setTimeout(() => particle.remove(), 3000);
                        }
                    }
                });
            });
            console.log('%c☠ NEO PORTFOLIO %c| %c<%= proyectos.size() %> PROYECTOS CARGADOS',
                'color:#dc2626;font-weight:bold;', 'color:#6b7280;', 'color:#22c55e;');
        });
    </script>
</body>
</html>