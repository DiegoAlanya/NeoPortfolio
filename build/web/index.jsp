<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NEO PORTFOLIO | Diego Alanya | Bloodpunk Cyber Demon</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/hero.css">
    <link rel="stylesheet" href="css/cards.css">
    <link rel="stylesheet" href="css/contact.css">
    <link rel="stylesheet" href="css/skills.css">
    <link rel="stylesheet" href="css/responsive.css">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
    <!-- Background Layers -->
    <div class="demon-runes"></div>
    <div class="vignette"></div>
    <div class="noise"></div>
    
    <!-- Particle Canvas -->
    <canvas id="particleCanvas"></canvas>
    
    <!-- Header Include -->
    <jsp:include page="includes/header.jsp" />
    
    <!-- Hero Section Include -->
    <jsp:include page="includes/hero.jsp" />
    
    <!-- Stats Section Include -->
    <jsp:include page="includes/stats.jsp" />
    
    <!-- About Section Include -->
    <jsp:include page="includes/about.jsp" />
    
    <!-- Footer Include -->
    <jsp:include page="includes/footer.jsp" />
    
    <!-- JavaScript -->
    <script src="js/particles.js"></script>
    <script src="js/main.js"></script>
    <script src="js/scroll.js"></script>
    <script src="js/animations.js"></script>
</body>
</html>