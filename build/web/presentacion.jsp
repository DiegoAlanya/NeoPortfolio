<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PRESENTACIÓN | NEO PORTFOLIO</title>
    
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/skills.css">
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
    <div class="demon-runes"></div>
    <div class="vignette"></div>
    <div class="noise"></div>
    <canvas id="particleCanvas"></canvas>
    
    <jsp:include page="includes/header.jsp" />
    
    <!-- Presentation Content -->
    <section class="skills-section" style="padding-top: 120px;">
        <div class="section-title-container">
            <div class="section-badge">PLAYER_PROFILE</div>
            <h1 class="section-title">PRESENTACIÓN</h1>
            <div class="section-subtitle">[ HELL SYSTEM ONLINE ]</div>
        </div>
        
        <!-- About Me -->
        <div style="max-width: 1400px; margin: 0 auto; padding: 0 40px;">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 60px; align-items: center; margin-bottom: 80px;">
                <div>
                    <h2 style="font-family: 'Teko', sans-serif; font-size: 48px; color: #f0f0f0; text-transform: uppercase; letter-spacing: 5px; margin-bottom: 20px;">
                        SOBRE MÍ
                    </h2>
                    <p style="font-family: 'Rajdhani', sans-serif; font-size: 18px; color: #555; line-height: 1.8; margin-bottom: 30px;">
                        Desarrollador de Sistemas con especialización en Java Web y tecnologías empresariales. 
                        Mi enfoque es crear sistemas robustos, eficientes y con una estética que rompe los límites 
                        de lo convencional. Inspirado en la oscuridad tecnológica y la precisión del código.
                    </p>
                    
                    <!-- Objective Cards -->
                    <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px;">
                        <div class="glass-blood" style="padding: 25px; text-align: center;">
                            <i class="fas fa-crosshairs" style="font-size: 30px; color: #ff0000; margin-bottom: 15px; text-shadow: 0 0 20px rgba(255,0,0,0.8);"></i>
                            <h3 style="font-family: 'Teko', sans-serif; font-size: 24px; color: #f0f0f0;">OBJETIVO</h3>
                            <p style="font-family: 'Rajdhani', sans-serif; color: #555;">Excelencia técnica</p>
                        </div>
                        
                        <div class="glass-blood" style="padding: 25px; text-align: center;">
                            <i class="fas fa-fire" style="font-size: 30px; color: #ff0000; margin-bottom: 15px; text-shadow: 0 0 20px rgba(255,0,0,0.8);"></i>
                            <h3 style="font-family: 'Teko', sans-serif; font-size: 24px; color: #f0f0f0;">PASIÓN</h3>
                            <p style="font-family: 'Rajdhani', sans-serif; color: #555;">Desarrollo web</p>
                        </div>
                        
                        <div class="glass-blood" style="padding: 25px; text-align: center;">
                            <i class="fas fa-bolt" style="font-size: 30px; color: #ff0000; margin-bottom: 15px; text-shadow: 0 0 20px rgba(255,0,0,0.8);"></i>
                            <h3 style="font-family: 'Teko', sans-serif; font-size: 24px; color: #f0f0f0;">ENERGÍA</h3>
                            <p style="font-family: 'Rajdhani', sans-serif; color: #555;">100% Gamer</p>
                        </div>
                        
                        <div class="glass-blood" style="padding: 25px; text-align: center;">
                            <i class="fas fa-skull" style="font-size: 30px; color: #ff0000; margin-bottom: 15px; text-shadow: 0 0 20px rgba(255,0,0,0.8);"></i>
                            <h3 style="font-family: 'Teko', sans-serif; font-size: 24px; color: #f0f0f0;">META</h3>
                            <p style="font-family: 'Rajdhani', sans-serif; color: #555;">Full Stack Elite</p>
                        </div>
                    </div>
                </div>
                
                <!-- Demon Illustration -->
                <div style="text-align: center;">
                    <img src="imagenes/demon-texture.png" alt="Demon" style="max-width: 100%; opacity: 0.7; filter: drop-shadow(0 0 50px rgba(255,0,0,0.3));">
                </div>
            </div>
            
            <!-- Skills -->
            <h2 style="font-family: 'Teko', sans-serif; font-size: 48px; color: #f0f0f0; text-transform: uppercase; text-align: center; margin-bottom: 40px; letter-spacing: 5px;">
                HABILIDADES
            </h2>
            
            <div class="skills-grid">
                <%
                String[][] skills = {
                    {"JAVA", "90%"},
                    {"JSP", "85%"},
                    {"HTML5", "95%"},
                    {"CSS3", "90%"},
                    {"JAVASCRIPT", "80%"},
                    {"MYSQL", "85%"},
                    {"GIT", "80%"},
                    {"NETBEANS", "90%"}
                };
                
                for (String[] skill : skills) {
                %>
                <div class="skill-card">
                    <div class="skill-name"><%= skill[0] %></div>
                    <div class="skill-bar-container">
                        <div class="skill-bar" style="width: 0%;" data-width="<%= skill[1] %>"></div>
                    </div>
                    <div class="skill-percentage"><%= skill[1] %></div>
                </div>
                <%
                }
                %>
            </div>
        </div>
    </section>
    
    <jsp:include page="includes/footer.jsp" />
    
    <script src="js/particles.js"></script>
    <script src="js/main.js"></script>
    <script src="js/scroll.js"></script>
    <script src="js/animations.js"></script>
</body>
</html>