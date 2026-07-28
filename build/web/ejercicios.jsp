<%@ page import="java.sql.*" %>
<%
    out.println("<h1>ACTUALIZANDO EJERCICIOS...</h1>");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://tokaido.proxy.rlwy.net:17686/railway", "root", "TyYcNUcOAoPabLfxQNUCEZVqjcIMRZRw"
        );
        Statement stmt = conn.createStatement();
        
        // Limpiar ejercicios existentes
        stmt.executeUpdate("DELETE FROM ejercicios");
        out.println("<p style='color:orange;'>? Ejercicios anteriores eliminados</p>");
        
        // Nuevos ejercicios
        String[][] ejercicios = {
            // SEMANA 1 (10)
            {"01","1","RECTÁNGULO","Área y perímetro de un rectángulo conociendo su base y altura"},
            {"01","2","CÍRCULO","Área y longitud de circunferencia conociendo su radio"},
            {"01","3","ROMBO","Área de un rombo conociendo sus diagonales"},
            {"01","4","CILINDRO","Área total y volumen de un cilindro conociendo radio y altura"},
            {"01","5","CUBO","Área y volumen de un cubo conociendo su lado"},
            {"01","6","DIVISIÓN ENTERA","Cociente y residuo de la división de dos números enteros"},
            {"01","7","NÚMERO INVERTIDO","Invertir un número de 5 dígitos (ej: 12345 ? 54321)"},
            {"01","8","CONVERSIÓN DE TIEMPO","Convertir segundos en horas, minutos y segundos"},
            {"01","9","REPARTO DE DINERO","Repartir dinero entre 5 hijos con porcentajes diferentes"},
            {"01","10","GASTOS DE FERIA","Calcular gastos de una empresa en feria por rubros"},
            
            // SEMANA 2 (6)
            {"02","1","DESCUENTO 11% + CARAMELOS","Descuento del 11% y caramelos de obsequio por compra"},
            {"02","2","DESCUENTO 7% + 7%","Aplica dos descuentos del 7% sucesivamente"},
            {"02","3","PAGO MENSUAL DEL EMPLEADO","Calcula el pago mensual del empleado con bonificaciones"},
            {"02","4","DONACIÓN AL HOSPITAL","Calcula la donación al hospital según monto de compra"},
            {"02","5","SUELDO DE VENDEDORES","Calcula sueldo base más comisiones por ventas"},
            {"02","6","SUELDO CON ESSALUD Y AFP","Descuentos por ESSALUD y AFP sobre sueldo bruto"},
            
            // SEMANA 3 (6)
            {"03","1","DESCUENTO 11%","Calcula descuento del 11% y caramelos de obsequio por compra"},
            {"03","2","DESCUENTO 10% + 10%","Aplica dos descuentos del 10% sucesivamente sobre la compra"},
            {"03","3","SUELDO EMPLEADO","Calcula sueldo con bonificación del 20% y descuento del 10%"},
            {"03","4","TRANSPORTE","Descuento del 7% y chocolates de obsequio por pasajes"},
            {"03","5","SUELDO VENDEDOR","Sueldo base S/300, comisión 9% y descuento 11% sobre ventas"},
            {"03","6","SUELDO ESSALUD + AFP","Descuentos por ESSALUD (9%) y AFP (10%) sobre sueldo bruto"},
            
            // SEMANA 4 (4)
            {"04","1","RENTA CAR","Alquiler de autos con 3 tipos de vehículo y recargo por km excedido"},
            {"04","2","HORAS EXTRAS","Cálculo de pago con horas extras al doble y triple"},
            {"04","3","ESTACIONAMIENTO","Tarifa de estacionamiento según el día de la semana"},
            {"04","4","PROMEDIO NOTAS","Promedio de 3 prácticas con bonus de +2 puntos en la tercera"},
            
            // SEMANA 5 (6)
            {"05","1","SERIE ARITMÉTICA","Imprime y suma la serie: 3, 10, 17, 24, 31... hasta n términos"},
            {"05","2","SERIE FRACCIONARIA","Imprime y suma la serie: 2/5, 5/9, 8/13, 11/17... hasta n términos"},
            {"05","3","DÍGITOS DE NÚMERO","Cantidad, suma de dígitos pares e impares de un número entero"},
            {"05","4","SERIE FACTORIAL","Suma de serie alternada con factoriales usando do...while"},
            {"05","5","VENTA DE CUADERNOS","Selección de producto y cantidad para calcular importe total"},
            {"05","6","STOCK ALEATORIO","Genera stock aleatorio para N productos y clasifica por rangos"},
            
            // SEMANA 6 (3)
            {"06","1","DULCE PORVENIR","Venta de chocolates con descuentos por cantidad y obsequio de caramelos"},
            {"06","2","ANGELITO AZULES","Venta de boletos de bus con descuento por calidad A y cantidad mayor a 4"},
            {"06","3","LIBRETAS MILITARES","Cálculo de descuento según edad y nivel del sistema de beneficio"},
            
            // SEMANA 7 (10)
            {"07","1","CONTADOR DE VOCALES","Cuenta vocales usando toLowerCase() y charAt()"},
            {"07","2","INVERSOR DE CADENAS","Invierte texto sin StringBuilder usando charAt()"},
            {"07","3","VALIDADOR DE CORREOS","Valida email con contains, indexOf y endsWith"},
            {"07","4","ENMASCARADOR DE TARJETAS","Muestra solo últimos 4 dígitos con substring y repeat"},
            {"07","5","ANALIZADOR DE NOMBRES","Capitaliza nombres con split, substring y toUpperCase"},
            {"07","6","DETECTOR DE PALÍNDROMOS","Verifica palíndromos con replace y toLowerCase"},
            {"07","7","CENSOR DE MALAS PALABRAS","Censura palabras prohibidas con replaceAll"},
            {"07","8","EXTRACTOR DE DOMINIOS","Extrae dominios de URLs con indexOf y substring"},
            {"07","9","LIMPIADOR DE FORMULARIOS","Limpia espacios con trim y replaceAll"},
            {"07","10","CONTADOR DE PALABRAS","Cuenta palabras con trim, split y length"},
            
            // SEMANA 8 (2)
            {"08","1","ÁREA DE CÍRCULO","Math.PI + Math.pow() para calcular área del círculo"},
            {"08","2","PITÁGORAS EXPRESS","Math.hypot() para calcular hipotenusa"},
            
            // SEMANA 9 (2)
            {"09","1","SIMULADOR DE DADOS RPG","Simula lanzamiento de dados para juegos de rol"},
            {"09","2","ECUACIONES CUADRÁTICAS","Resuelve ecuaciones cuadráticas con fórmula general"},
            
            // SEMANA 10 (2)
            {"10","1","CONVERSOR TRIGONOMÉTRICO","Convierte entre grados y radianes con Math"},
            {"10","2","SISTEMA ANTI-DESBORDAMIENTO","Manejo de overflow con Math.addExact y multiplyExact"},
            
            // SEMANA 11 (2)
            {"11","1","INTERÉS COMPUESTO CONTINUO","Cálculo de interés compuesto con fórmula continua"},
            {"11","2","DISTANCIA EUCLIDIANA","Calcula distancia entre dos puntos en plano cartesiano"}
        };
        
        for (String[] e : ejercicios) {
            stmt.executeUpdate("INSERT INTO ejercicios (semana, numero, titulo, descripcion) VALUES ('"+e[0]+"','"+e[1]+"','"+e[2]+"','"+e[3]+"')");
        }
        
        out.println("<p style='color:green;'>? " + ejercicios.length + " ejercicios insertados</p>");
        out.println("<h2 style='color:#22c55e;'>? TODO LISTO</h2>");
        
        stmt.close(); conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>? " + e.getMessage() + "</p>");
    }
%> 
