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
                    <a href="ver-proyecto.jsp?week=<%= weekNum %>" class="card-button">
                        VER PROYECTO <i class="fas fa-arrow-right" style="margin-left:8px;"></i>
                    </a>
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
        });
    </script>
</body>
</html>