<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // =============================================
    // OBTENER PARÁMETRO DE SEMANA
    // =============================================
    String weekParam = request.getParameter("week");
    if (weekParam == null || weekParam.isEmpty()) {
        weekParam = "01";
    }
    
    // Convertir a número
    int weekNumber = Integer.parseInt(weekParam);
    
    // =============================================
    // CALCULAR RUTAS DE CAPTURAS
    // WEEK 01 → captura_1.png y captura_2.png
    // WEEK 02 → captura_3.png y captura_4.png
    // WEEK N  → captura_(N*2-1).png y captura_(N*2).png
    // =============================================
    int captura1Num = (weekNumber * 2) - 1;
    int captura2Num = weekNumber * 2;
    String captura1 = "imagenes/capturas/captura_" + captura1Num + ".png";
    String captura2 = "imagenes/capturas/captura_" + captura2Num + ".png";
    
    // =============================================
    // BASE DE DATOS DE LOS 16 PROYECTOS
    // =============================================
    String[][] proyectos = {
        {"01", "Fundamentos Web", 
         "Durante la primera semana se exploraron los fundamentos del desarrollo web, construyendo páginas con HTML5 semántico, formularios accesibles y una correcta jerarquía de encabezados. Se sentaron las bases para todo el ciclo formativo.", 
         "HTML5", "VS CODE"},
        
        {"02", "CSS3 Avanzado", 
         "Se profundizó en el diseño con CSS3, implementando animaciones, transiciones, gradientes y layouts modernos. Cada proyecto demostró el poder del diseño web sin necesidad de frameworks externos.", 
         "CSS3", "HTML5"},
        
        {"03", "Flexbox & Grid", 
         "Dominio de los sistemas de layout modernos. Se crearon estructuras complejas usando Flexbox y CSS Grid, logrando diseños 100% responsivos con código limpio y eficiente.", 
         "CSS3", "FLEXBOX"},
        
        {"04", "JavaScript Essentials", 
         "Introducción a la programación con JavaScript vanilla. Variables, funciones, eventos del DOM y manipulación dinámica del contenido HTML sentaron las bases del desarrollo web interactivo.", 
         "JAVASCRIPT", "DOM"},
        
        {"05", "JavaScript Avanzado", 
         "ES6+, arrow functions, promesas, async/await y consumo de APIs REST. Se desarrollaron aplicaciones web dinámicas con manejo de datos en tiempo real y programación asíncrona.", 
         "JAVASCRIPT", "ES6+"},
        
        {"06", "Programación OO", 
         "Fundamentos de la programación orientada a objetos con Java. Clases, objetos, herencia, polimorfismo, encapsulamiento y abstracción aplicados en proyectos prácticos del mundo real.", 
         "JAVA", "POO"},
        
        {"07", "Colecciones Java", 
         "Manejo avanzado de estructuras de datos en Java: ArrayList, LinkedList, HashMap, HashSet, TreeMap. Se implementaron soluciones eficientes para problemas complejos de desarrollo.", 
         "JAVA", "COLLECTIONS"},
        
        {"08", "MySQL Database", 
         "Diseño y gestión de bases de datos relacionales con MySQL. Creación de tablas normalizadas, consultas SQL avanzadas, JOINs, procedimientos almacenados y optimización de rendimiento.", 
         "MYSQL", "SQL"},
        
        {"09", "JSP Fundamentals", 
         "Introducción a Java Server Pages. Se aprendió a crear páginas web dinámicas con JSP, uso de expresiones, scriptlets, directivas y conexión con bases de datos MySQL.", 
         "JSP", "SERVLET"},
        
        {"10", "JSP Avanzado", 
         "Técnicas avanzadas de JSP: includes JSPF, custom tags, Expression Language (EL), JSTL. Modularización de proyectos web Java empresariales con componentes reutilizables.", 
         "JSP", "JSPF"},
        
        {"11", "MVC Pattern", 
         "Implementación del patrón de arquitectura Modelo-Vista-Controlador en aplicaciones Java Web. Separación de responsabilidades, controladores Servlet y vistas JSP para aplicaciones escalables.", 
         "MVC", "JAVA"},
        
        {"12", "CRUD Operations", 
         "Desarrollo completo de operaciones Create, Read, Update, Delete con MySQL y JSP. Formularios conectados a base de datos con validaciones del lado del servidor y del cliente.", 
         "CRUD", "MYSQL"},
        
        {"13", "Git & Version Control", 
         "Control de versiones profesional con Git y GitHub. Commits semánticos, ramas, merges, pull requests, resolución de conflictos y flujo de trabajo colaborativo en equipo.", 
         "GIT", "GITHUB"},
        
        {"14", "NetBeans IDE", 
         "Dominio completo del entorno de desarrollo integrado NetBeans. Configuración de proyectos Java Web, depuración, refactorización, pruebas unitarias y despliegue en Apache Tomcat.", 
         "NETBEANS", "JAVA"},
        
        {"15", "Web Security", 
         "Principios fundamentales de seguridad en aplicaciones web: validación de entradas, prevención de SQL Injection, XSS, CSRF, autenticación segura y manejo de sesiones.", 
         "SECURITY", "HTTPS"},
        
        {"16", "Final Project", 
         "Proyecto integrador final aplicando todos los conocimientos adquiridos durante las 16 semanas. Desarrollo Full Stack completo con JSP, MySQL, diseño profesional y despliegue en servidor.", 
         "FULL STACK", "JSP"}
    };
    
    // =============================================
    // BUSCAR DATOS DEL PROYECTO ACTUAL
    // =============================================
    String weekNum = weekParam;
    String projectTitle = "Proyecto";
    String projectDescription = "Descripción del proyecto.";
    String tech1 = "Tecnología";
    String tech2 = "Tecnología";
    
    for (String[] proyecto : proyectos) {
        if (proyecto[0].equals(weekParam)) {
            weekNum = proyecto[0];
            projectTitle = proyecto[1];
            projectDescription = proyecto[2];
            tech1 = proyecto[3];
            tech2 = proyecto[4];
            break;
        }
    }
    
    // =============================================
    // CALCULAR NAVEGACIÓN ANTERIOR/SIGUIENTE
    // =============================================
    int currentWeek = Integer.parseInt(weekNum);
    int nextWeek = currentWeek + 1;
    int prevWeek = currentWeek - 1;
    String nextWeekStr = String.format("%02d", nextWeek);
    String prevWeekStr = String.format("%02d", prevWeek);
    
    String nextProjectTitle = "";
    String prevProjectTitle = "";
    
    for (String[] proyecto : proyectos) {
        if (proyecto[0].equals(nextWeekStr)) {
            nextProjectTitle = proyecto[1];
        }
        if (proyecto[0].equals(prevWeekStr)) {
            prevProjectTitle = proyecto[1];
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WEEK_<%= weekNum %> - <%= projectTitle %> | NEO PORTFOLIO</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;600;700;800;900&family=Rajdhani:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- CSS Base del Proyecto -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/responsive.css">
    
    <!-- CSS Exclusivo de Ver Proyecto -->
    <link rel="stylesheet" href="css/ver-proyecto.css">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
    <!-- ============================================= -->
    <!-- BACKGROUND LAYERS -->
    <!-- ============================================= -->
    <div class="demon-runes"></div>
    <div class="vignette"></div>
    <div class="noise"></div>
    
    <!-- Particle Canvas -->
    <canvas id="particleCanvas"></canvas>
    
    <!-- ============================================= -->
    <!-- HEADER -->
    <!-- ============================================= -->
    <%@ include file="includes/header.jsp" %>
    
    <!-- ============================================= -->
    <!-- MAIN CONTENT -->
    <!-- ============================================= -->
    <main class="vp-main">
        
        <!-- TOP BAR: Botón volver + Navegación entre semanas -->
        <div class="vp-top-bar">
            <a href="trabajos.jsp" class="vp-back-btn">
                <i class="fas fa-arrow-left"></i>
                <span>VOLVER A MISIONES</span>
            </a>
            
            <div class="vp-week-navigation">
                <% if (prevWeek >= 1) { %>
                <a href="ver-proyecto.jsp?week=<%= prevWeekStr %>" class="vp-nav-btn" title="Semana <%= prevWeekStr %>: <%= prevProjectTitle %>">
                    <i class="fas fa-chevron-left"></i> WEEK_<%= prevWeekStr %>
                </a>
                <% } %>
                
                <span class="vp-current-week">WEEK_<%= weekNum %></span>
                
                <% if (nextWeek <= 16) { %>
                <a href="ver-proyecto.jsp?week=<%= nextWeekStr %>" class="vp-nav-btn" title="Semana <%= nextWeekStr %>: <%= nextProjectTitle %>">
                    WEEK_<%= nextWeekStr %> <i class="fas fa-chevron-right"></i>
                </a>
                <% } %>
            </div>
        </div>
        
        <!-- PROJECT CARD -->
        <article class="vp-project-card">
            
            <!-- WEEK BADGE -->
            <div class="vp-week-badge">
                <span class="vp-badge-icon">☠</span>
                WEEK_<%= weekNum %> &ndash; MISSION COMPLETE
                <span class="vp-badge-icon">☠</span>
            </div>
            
            <!-- PROJECT TITLE -->
            <h1 class="vp-project-title">
                <%= projectTitle.toUpperCase() %>
            </h1>
            
            <!-- PROJECT DESCRIPTION -->
            <p class="vp-project-description">
                <%= projectDescription %>
            </p>
            
            <!-- DIVIDER -->
            <div class="vp-divider">
                <span class="vp-divider-line"></span>
                <i class="fas fa-skull vp-divider-icon"></i>
                <span class="vp-divider-line"></span>
            </div>
            
            <!-- STACK SECTION -->
            <div class="vp-stack-section">
                <h3 class="vp-stack-title">
                    <i class="fas fa-microchip"></i> STACK UTILIZADO
                </h3>
                <div class="vp-stack-tags">
                    <span class="vp-tag">
                        <i class="fas fa-code"></i> <%= tech1 %>
                    </span>
                    <span class="vp-tag">
                        <i class="fas fa-code"></i> <%= tech2 %>
                    </span>
                </div>
            </div>
            
            <!-- CAPTURES SECTION -->
            <div class="vp-captures-section">
                <h3 class="vp-captures-title">
                    <i class="fas fa-images"></i> INFOGRAFIAS DEL PROYECTO
                    <i class="fas fa-chevron-right vp-chevron"></i>
                </h3>
                
                <div class="vp-captures-grid">
                    <!-- CAPTURA 1 -->
                    <div class="vp-capture-card">
                        <div class="vp-capture-img-container">
                            <img src="<%= captura1 %>?v=<%= System.currentTimeMillis() %>" 
                                 alt="<%= projectTitle %> - Captura 1" 
                                 class="vp-capture-img"
                                 onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22800%22 height=%22500%22%3E%3Crect fill=%22%23111111%22 width=%22800%22 height=%22500%22/%3E%3Crect fill=%22%23222222%22 x=%2250%22 y=%2250%22 width=%22700%22 height=%22400%22 rx=%225%22/%3E%3Ctext fill=%22%23dc2626%22 font-family=%22monospace%22 font-size=%2230%22 x=%22400%22 y=%22230%22 text-anchor=%22middle%22 font-weight=%22bold%22%3EWEEK <%= weekNum %>%3C/text%3E%3Ctext fill=%22%236b7280%22 font-family=%22monospace%22 font-size=%2218%22 x=%22400%22 y=%22280%22 text-anchor=%22middle%22%3ECAPTURA <%= captura1Num %>%3C/text%3E%3Ctext fill=%22%23444444%22 font-family=%22monospace%22 font-size=%2213%22 x=%22400%22 y=%22320%22 text-anchor=%22middle%22%3EColoca tu imagen aquí%3C/text%3E%3C/svg%3E';">
                            <div class="vp-capture-overlay">
                                <i class="fas fa-search-plus"></i>
                            </div>
                            <div class="vp-capture-number">01</div>
                        </div>
                        <p class="vp-capture-label">
                            <i class="fas fa-image"></i> INFOGRAFIA_<%= captura1Num %>.PNG
                        </p>
                    </div>
                    
                    <!-- CAPTURA 2 -->
                    <div class="vp-capture-card">
                        <div class="vp-capture-img-container">
                            <img src="<%= captura2 %>?v=<%= System.currentTimeMillis() %>" 
                                 alt="<%= projectTitle %> - Captura 2" 
                                 class="vp-capture-img"
                                 onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22800%22 height=%22500%22%3E%3Crect fill=%22%23111111%22 width=%22800%22 height=%22500%22/%3E%3Crect fill=%22%23222222%22 x=%2250%22 y=%2250%22 width=%22700%22 height=%22400%22 rx=%225%22/%3E%3Ctext fill=%22%23dc2626%22 font-family=%22monospace%22 font-size=%2230%22 x=%22400%22 y=%22230%22 text-anchor=%22middle%22 font-weight=%22bold%22%3EWEEK <%= weekNum %>%3C/text%3E%3Ctext fill=%22%236b7280%22 font-family=%22monospace%22 font-size=%2218%22 x=%22400%22 y=%22280%22 text-anchor=%22middle%22%3ECAPTURA <%= captura2Num %>%3C/text%3E%3Ctext fill=%22%23444444%22 font-family=%22monospace%22 font-size=%2213%22 x=%22400%22 y=%22320%22 text-anchor=%22middle%22%3EColoca tu imagen aquí%3C/text%3E%3C/svg%3E';">
                            <div class="vp-capture-overlay">
                                <i class="fas fa-search-plus"></i>
                            </div>
                            <div class="vp-capture-number">02</div>
                        </div>
                        <p class="vp-capture-label">
                            <i class="fas fa-image"></i> INFOGRAFIA_<%= captura2Num %>.PNG
                        </p>
                    </div>
                </div>
            </div>
            
            <!-- ============================================= -->
            <!-- ACTION BUTTONS - CORREGIDO -->
            <!-- ============================================= -->
            <div class="vp-actions">
                <!-- BOTÓN VER DEMO → AHORA ABRE EL PDF -->
                <a href="ver-pdf.jsp?week=<%= weekNum %>" class="vp-btn vp-btn-primary">
                    <i class="fas fa-file-pdf"></i> VER DEMO (PDF)
                </a>
                <a href="trabajos.jsp" class="vp-btn vp-btn-secondary">
                    <i class="fas fa-arrow-left"></i> REGRESAR
                </a>
            </div>
            
        </article>
        
        <!-- BOTTOM NAVIGATION: Anterior / Siguiente -->
        <div class="vp-bottom-navigation">
            <% if (prevWeek >= 1) { %>
            <a href="ver-proyecto.jsp?week=<%= prevWeekStr %>" class="vp-bottom-nav-btn vp-prev">
                <i class="fas fa-arrow-left"></i>
                <div>
                    <span class="vp-nav-label">MISIÓN ANTERIOR</span>
                    <span class="vp-nav-title">WEEK_<%= prevWeekStr %> &ndash; <%= prevProjectTitle %></span>
                </div>
            </a>
            <% } else { %>
            <div></div>
            <% } %>
            
            <% if (nextWeek <= 16) { %>
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
    
    <!-- ============================================= -->
    <!-- FOOTER -->
    <!-- ============================================= -->
    <%@ include file="includes/footer.jsp" %>
    
    <!-- ============================================= -->
    <!-- JAVASCRIPT -->
    <!-- ============================================= -->
    <script src="js/particles.js"></script>
    <script src="js/main.js"></script>
    <script src="js/scroll.js"></script>
    <script src="js/animations.js"></script>
    <script src="js/ver-proyecto.js"></script>
</body>
</html>