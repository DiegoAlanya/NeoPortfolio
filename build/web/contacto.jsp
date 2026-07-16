<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ESTABLISH_CONNECTION | NEO PORTFOLIO</title>
    
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/contact.css">
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
    
    <!-- Contact Section -->
    <section class="contact-section" style="padding-top: 120px;">
        <div class="section-title-container">
            <div class="section-badge">[ ESTABLISH_CONNECTION ]</div>
            <h1 class="section-title">CONTACTO</h1>
            <div class="section-subtitle">◈ HELL SYSTEM ONLINE V6.6.6 ◈</div>
        </div>
        
        <div class="contact-container">
            <!-- Contact Info Cards -->
            <div class="contact-info">
                <div class="contact-card">
                    <div class="contact-card-icon">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="contact-card-title">EMAIL</div>
                    <a href="mailto:diego@neoportfolio.com" class="contact-card-value">
                        diego@neoportfolio.com
                    </a>
                </div>
                
                <div class="contact-card">
                    <div class="contact-card-icon">
                        <i class="fab fa-github"></i>
                    </div>
                    <div class="contact-card-title">GITHUB</div>
                    <a href="#" class="contact-card-value">
                        /diegoalanya
                    </a>
                </div>
                
                <div class="contact-card">
                    <div class="contact-card-icon">
                        <i class="fab fa-linkedin"></i>
                    </div>
                    <div class="contact-card-title">LINKEDIN</div>
                    <a href="#" class="contact-card-value">
                        /in/diegoalanya
                    </a>
                </div>
                
                <div class="contact-card">
                    <div class="contact-card-icon">
                        <i class="fab fa-whatsapp"></i>
                    </div>
                    <div class="contact-card-title">WHATSAPP</div>
                    <a href="#" class="contact-card-value">
                        +51 999 999 999
                    </a>
                </div>
            </div>
            
            <!-- Contact Form -->
            <div class="contact-form-container">
                <h2 class="form-title">ENVIAR TRANSMISIÓN</h2>
                <p class="form-subtitle">[ SECURE_CHANNEL_ACTIVE ]</p>
                
                <form class="contact-form" action="#" method="POST">
                    <div class="form-group">
                        <input type="text" name="nombre" class="form-input" placeholder="NOMBRE" required>
                    </div>
                    
                    <div class="form-group">
                        <input type="email" name="email" class="form-input" placeholder="EMAIL" required>
                    </div>
                    
                    <div class="form-group">
                        <input type="text" name="asunto" class="form-input" placeholder="ASUNTO" required>
                    </div>
                    
                    <div class="form-group">
                        <textarea name="mensaje" class="form-input form-textarea" placeholder="MENSAJE" required></textarea>
                    </div>
                    
                    <button type="submit" class="form-submit">
                        ENVIAR TRANSMISIÓN <i class="fas fa-paper-plane" style="margin-left: 10px;"></i>
                    </button>
                </form>
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