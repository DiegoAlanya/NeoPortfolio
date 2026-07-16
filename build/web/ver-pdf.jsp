<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String weekParam = request.getParameter("week");
    if (weekParam == null || weekParam.isEmpty()) {
        weekParam = "01";
    }
    
    int weekNumber = Integer.parseInt(weekParam);
    String weekFormatted = String.format("%02d", weekNumber);
    String pdfPath = "pdf/semana_" + weekFormatted + ".pdf";
    
    String[][] proyectos = {
        {"01", "Fundamentos Web"},
        {"02", "CSS3 Avanzado"},
        {"03", "Flexbox & Grid"},
        {"04", "JavaScript Essentials"},
        {"05", "JavaScript Avanzado"},
        {"06", "Programación OO"},
        {"07", "Colecciones Java"},
        {"08", "MySQL Database"},
        {"09", "JSP Fundamentals"},
        {"10", "JSP Avanzado"},
        {"11", "MVC Pattern"},
        {"12", "CRUD Operations"},
        {"13", "Git & Version Control"},
        {"14", "NetBeans IDE"},
        {"15", "Web Security"},
        {"16", "Final Project"}
    };
    
    String projectTitle = "Proyecto";
    for (String[] proyecto : proyectos) {
        if (proyecto[0].equals(weekFormatted)) {
            projectTitle = proyecto[1];
            break;
        }
    }
    
    int nextWeek = weekNumber + 1;
    int prevWeek = weekNumber - 1;
    String nextWeekStr = String.format("%02d", nextWeek);
    String prevWeekStr = String.format("%02d", prevWeek);
    
    String nextProject = "";
    String prevProject = "";
    for (String[] proyecto : proyectos) {
        if (proyecto[0].equals(nextWeekStr)) nextProject = proyecto[1];
        if (proyecto[0].equals(prevWeekStr)) prevProject = proyecto[1];
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WEEK_<%= weekFormatted %> - <%= projectTitle %> | PDF | NEO PORTFOLIO</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;600;700;800;900&family=Rajdhani:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="stylesheet" href="css/ver-pdf.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
    <div class="demon-runes"></div>
    <div class="vignette"></div>
    <div class="noise"></div>
    <canvas id="particleCanvas"></canvas>
    
    <%@ include file="includes/header.jsp" %>
    
    <main class="pdf-main">
        
        <!-- TOP BAR -->
        <div class="pdf-top-bar">
            <a href="ver-proyecto.jsp?week=<%= weekFormatted %>" class="pdf-back-btn">
                <i class="fas fa-arrow-left"></i> VOLVER AL PROYECTO
            </a>
            
            <div class="pdf-info">
                <span class="pdf-badge">☠ WEEK_<%= weekFormatted %></span>
                <h1 class="pdf-title"><%= projectTitle.toUpperCase() %></h1>
            </div>
            
            <a href="<%= pdfPath %>" download class="pdf-btn-download">
                <i class="fas fa-download"></i> DESCARGAR
            </a>
        </div>
        
        <!-- VISOR PDF -->
        <div class="pdf-viewer-container">
            
            <!-- TOOLBAR -->
            <div class="pdf-toolbar">
                <div class="pdf-toolbar-left">
                    <button class="pdf-tool-btn" onclick="zoomOut()" title="Alejar">
                        <i class="fas fa-search-minus"></i>
                    </button>
                    <span class="pdf-zoom-level" id="zoomLevel">100%</span>
                    <button class="pdf-tool-btn" onclick="zoomIn()" title="Acercar">
                        <i class="fas fa-search-plus"></i>
                    </button>
                    <span class="pdf-tool-divider"></span>
                    <button class="pdf-tool-btn" onclick="resetZoom()" title="Reset">
                        <i class="fas fa-expand"></i>
                    </button>
                </div>
                
                <div class="pdf-toolbar-right">
                    <button class="pdf-tool-btn" onclick="rotateLeft()" title="Rotar izquierda">
                        <i class="fas fa-undo"></i>
                    </button>
                    <button class="pdf-tool-btn" onclick="rotateRight()" title="Rotar derecha">
                        <i class="fas fa-redo"></i>
                    </button>
                    <span class="pdf-tool-divider"></span>
                    <button class="pdf-tool-btn" onclick="toggleFullscreen()" title="Pantalla completa">
                        <i class="fas fa-expand-arrows-alt"></i>
                    </button>
                </div>
            </div>
            
            <!-- EMBED PDF -->
            <div class="pdf-embed-container" id="pdfContainer">
                <embed src="<%= pdfPath %>" 
                       type="application/pdf" 
                       class="pdf-embed" 
                       id="pdfEmbed">
                
                <!-- MENSAJE SI NO HAY PDF -->
                <div class="pdf-no-file" id="pdfNoFile" style="display:none;">
                    <div class="pdf-no-file-content">
                        <i class="fas fa-file-pdf"></i>
                        <h2>PDF NO ENCONTRADO</h2>
                        <p>El archivo no existe todavía.</p>
                        <p class="pdf-hint">Coloca tu PDF en:<br><code>web/pdf/semana_<%= weekFormatted %>.pdf</code></p>
                        <div class="pdf-no-file-actions">
                            <a href="ver-proyecto.jsp?week=<%= weekFormatted %>" class="pdf-btn-secondary">
                                <i class="fas fa-arrow-left"></i> VOLVER
                            </a>
                            <button class="pdf-btn-primary" onclick="location.reload()">
                                <i class="fas fa-sync"></i> REINTENTAR
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
        
        <!-- NAVEGACIÓN INFERIOR -->
        <div class="pdf-bottom-nav">
            <% if (prevWeek >= 1) { %>
            <a href="ver-pdf.jsp?week=<%= prevWeekStr %>" class="pdf-nav-btn">
                <i class="fas fa-arrow-left"></i>
                <div>
                    <span>ANTERIOR</span>
                    <strong>WEEK_<%= prevWeekStr %> - <%= prevProject %></strong>
                </div>
            </a>
            <% } else { %><div></div><% } %>
            
            <a href="ver-proyecto.jsp?week=<%= weekFormatted %>" class="pdf-nav-center">
                <i class="fas fa-eye"></i> VER PROYECTO
            </a>
            
            <% if (nextWeek <= 16) { %>
            <a href="ver-pdf.jsp?week=<%= nextWeekStr %>" class="pdf-nav-btn" style="text-align:right;">
                <div>
                    <span>SIGUIENTE</span>
                    <strong>WEEK_<%= nextWeekStr %> - <%= nextProject %></strong>
                </div>
                <i class="fas fa-arrow-right"></i>
            </a>
            <% } else { %><div></div><% } %>
        </div>
        
    </main>
    
    <%@ include file="includes/footer.jsp" %>
    
    <script src="js/particles.js"></script>
    <script src="js/main.js"></script>
    <script src="js/scroll.js"></script>
    <script src="js/animations.js"></script>
    <script src="js/ver-pdf.js"></script>
</body>
</html>