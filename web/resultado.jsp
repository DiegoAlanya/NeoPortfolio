<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String week = request.getParameter("week");
    String ej = request.getParameter("ej");
    if (week == null) week = "01";
    if (ej == null) ej = "1";
    
    String titulo = "", descripcion = "";
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://tokaido.proxy.rlwy.net:17686/railway?useSSL=false&serverTimezone=UTC",
            "root", "TyYcNUcOAoPabLfxQNUCEZVqjcIMRZRw"
        );
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM ejercicios WHERE semana = ? AND numero = ?");
        ps.setString(1, week);
        ps.setString(2, ej);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            titulo = rs.getString("titulo");
            descripcion = rs.getString("descripcion");
        }
        rs.close(); ps.close(); conn.close();
    } catch (Exception e) {}
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title><%= titulo %> | NEO PORTFOLIO</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .resultado-container { max-width: 900px; margin: 120px auto 60px; padding: 0 20px; }
        .resultado-card { background: #111; border: 1px solid rgba(34,197,94,0.3); padding: 40px; }
        .resultado-card h1 { font-family: 'Orbitron', sans-serif; color: #22c55e; letter-spacing: 3px; font-size: 24px; }
        .desc { font-family: 'Rajdhani', sans-serif; color: #9ca3af; font-size: 16px; }
        .input-group { margin: 20px 0; }
        .input-group label { display: block; font-family: 'Orbitron', sans-serif; color: #fff; font-size: 11px; letter-spacing: 2px; margin-bottom: 8px; }
        .input-group input { width: 100%; padding: 14px; background: #0a0a0a; border: 1px solid rgba(34,197,94,0.3); color: #22c55e; font-family: 'Courier New', monospace; font-size: 18px; outline: none; }
        .input-group input:focus { border-color: #22c55e; box-shadow: 0 0 20px rgba(34,197,94,0.2); }
        .btn-calcular { display: inline-block; padding: 16px 35px; background: linear-gradient(135deg, #166534, #22c55e); color: #fff; border: none; font-family: 'Orbitron', sans-serif; font-size: 14px; font-weight: 700; letter-spacing: 3px; cursor: pointer; text-transform: uppercase; margin: 15px 0; box-shadow: 0 0 25px rgba(34,197,94,0.3); transition: all 0.3s; }
        .btn-calcular:hover { box-shadow: 0 0 45px rgba(34,197,94,0.6); transform: translateY(-2px); }
        .resultado-box { background: #0a0a0a; border: 1px solid #22c55e; padding: 20px; margin: 20px 0; font-family: 'Courier New', monospace; color: #22c55e; font-size: 16px; min-height: 30px; white-space: pre-wrap; }
        .codigo-box { background: #0a0a0a; border: 1px solid #333; padding: 20px; margin: 20px 0; font-family: 'Courier New', monospace; color: #fff; white-space: pre-wrap; font-size: 13px; }
        .back-btn { display: inline-block; padding: 12px 25px; border: 1px solid #dc2626; color: #dc2626; text-decoration: none; font-family: 'Orbitron', sans-serif; font-size: 12px; letter-spacing: 2px; margin-bottom: 30px; transition: all 0.3s; }
        .back-btn:hover { background: rgba(220,38,38,0.1); box-shadow: 0 0 20px rgba(220,38,38,0.3); }
    </style>
</head>
<body>
    <div class="demon-runes"></div>
    <div class="vignette"></div>
    <div class="noise"></div>
    <canvas id="particleCanvas"></canvas>
    <%@ include file="includes/header.jsp" %>
    
    <div class="resultado-container">
        <a href="ejercicios.jsp?week=<%= week %>" class="back-btn"><i class="fas fa-arrow-left"></i> VOLVER A EJERCICIOS</a>
        
        <div class="resultado-card">
            <h1>☠ EJERCICIO <%= ej %> - <%= titulo %></h1>
            <p class="desc"><%= descripcion %></p>
            
            <div id="inputs-container"></div>
            
            <button class="btn-calcular" onclick="calcular()"><i class="fas fa-skull"></i> CALCULAR</button>
            
            <h3 style="font-family:'Orbitron',sans-serif;color:#22c55e;letter-spacing:2px;">RESULTADO</h3>
            <div class="resultado-box" id="resultado">Esperando cálculo...</div>
            
            <h3 style="font-family:'Orbitron',sans-serif;color:#fff;letter-spacing:2px;margin-top:30px;">CÓDIGO JAVA</h3>
            <div class="codigo-box" id="codigo">Cargando...</div>
        </div>
    </div>
    
    <%@ include file="includes/footer.jsp" %>
    <script src="js/particles.js"></script>
    <script>
        const week = '<%= week %>';
        const ej = '<%= ej %>';
        const key = week + '_' + ej;
        
        const ejercicios = {
            // SEMANA 1 (10 ejercicios)
            '01_1': { inputs: [{label:'BASE (cm)', id:'base', val:'10'},{label:'ALTURA (cm)', id:'altura', val:'5'}], codigo:'public class Rectangulo {\n    public static void main(String[] args) {\n        double base = VALOR_BASE;\n        double altura = VALOR_ALTURA;\n        double area = base * altura;\n        double perimetro = 2 * (base + altura);\n        System.out.println("Area: " + area + " cm2");\n        System.out.println("Perimetro: " + perimetro + " cm");\n    }\n}', calcular:function(v){let b=parseFloat(v.base),a=parseFloat(v.altura);return'Base: '+b+' cm\nAltura: '+a+' cm\nArea: '+(b*a)+' cm2\nPerimetro: '+(2*(b+a))+' cm';} },
            '01_2': { inputs: [{label:'RADIO (cm)', id:'radio', val:'7'}], codigo:'public class Circulo {\n    public static void main(String[] args) {\n        double r = VALOR_RADIO;\n        double area = Math.PI * r * r;\n        double longi = 2 * Math.PI * r;\n        System.out.printf("Area: %.2f cm2%n", area);\n        System.out.printf("Longitud: %.2f cm%n", longi);\n    }\n}', calcular:function(v){let r=parseFloat(v.radio);return'Area: '+(Math.PI*r*r).toFixed(2)+' cm2\nLongitud: '+(2*Math.PI*r).toFixed(2)+' cm';} },
            '01_3': { inputs: [{label:'DIAGONAL MAYOR', id:'dm', val:'12'},{label:'DIAGONAL MENOR', id:'dmen', val:'8'}], codigo:'public class Rombo {\n    public static void main(String[] args) {\n        double D = VALOR_DM, d = VALOR_DMEN;\n        double area = (D * d) / 2;\n        System.out.println("Area: " + area + " cm2");\n    }\n}', calcular:function(v){let a=(parseFloat(v.dm)*parseFloat(v.dmen))/2;return'Area: '+a+' cm2';} },
            '01_4': { inputs: [{label:'RADIO (cm)', id:'radio', val:'5'},{label:'ALTURA (cm)', id:'altura', val:'10'}], codigo:'public class Cilindro {\n    public static void main(String[] args) {\n        double r = VALOR_RADIO, h = VALOR_ALTURA;\n        double area = 2 * Math.PI * r * (r + h);\n        double vol = Math.PI * r * r * h;\n        System.out.printf("Area: %.2f cm2%n", area);\n        System.out.printf("Volumen: %.2f cm3%n", vol);\n    }\n}', calcular:function(v){let r=parseFloat(v.radio),h=parseFloat(v.altura);return'Area: '+(2*Math.PI*r*(r+h)).toFixed(2)+' cm2\nVolumen: '+(Math.PI*r*r*h).toFixed(2)+' cm3';} },
            '01_5': { inputs: [{label:'LADO (cm)', id:'lado', val:'6'}], codigo:'public class Cubo {\n    public static void main(String[] args) {\n        double l = VALOR_LADO;\n        double area = 6 * l * l;\n        double vol = l * l * l;\n        System.out.println("Area: " + area + " cm2");\n        System.out.println("Volumen: " + vol + " cm3");\n    }\n}', calcular:function(v){let l=parseFloat(v.lado);return'Area: '+(6*l*l)+' cm2\nVolumen: '+(l*l*l)+' cm3';} },
            '01_6': { inputs: [{label:'DIVIDENDO', id:'a', val:'25'},{label:'DIVISOR', id:'b', val:'4'}], codigo:'public class DivisionEntera {\n    public static void main(String[] args) {\n        int a = VALOR_A, b = VALOR_B;\n        System.out.println("Cociente: " + (a/b));\n        System.out.println("Residuo: " + (a%b));\n    }\n}', calcular:function(v){let a=parseInt(v.a),b=parseInt(v.b);return'Cociente: '+Math.floor(a/b)+'\nResiduo: '+(a%b);} },
            '01_7': { inputs: [{label:'NUMERO (5 digitos)', id:'num', val:'12345'}], codigo:'public class NumeroInvertido {\n    public static void main(String[] args) {\n        int n = VALOR_NUM, inv = 0;\n        while (n > 0) { inv = inv * 10 + n % 10; n /= 10; }\n        System.out.println("Invertido: " + inv);\n    }\n}', calcular:function(v){let n=v.num,inv='';for(let i=n.length-1;i>=0;i--)inv+=n[i];return'Original: '+n+'\nInvertido: '+inv;} },
            '01_8': { inputs: [{label:'SEGUNDOS', id:'seg', val:'3665'}], codigo:'public class ConversionTiempo {\n    public static void main(String[] args) {\n        int t = VALOR_SEG;\n        int h = t/3600, m = (t%3600)/60, s = t%60;\n        System.out.println(h+"h "+m+"m "+s+"s");\n    }\n}', calcular:function(v){let t=parseInt(v.seg),h=Math.floor(t/3600),m=Math.floor((t%3600)/60),s=t%60;return h+'h '+m+'m '+s+'s';} },
            '01_9': { inputs: [{label:'DINERO TOTAL (S/)', id:'dinero', val:'1000'}], codigo:'public class RepartoDinero {\n    public static void main(String[] args) {\n        double t = VALOR_DINERO;\n        double[] p = {0.30,0.25,0.20,0.15,0.10};\n        for(int i=0;i<5;i++)\n            System.out.printf("Hijo %d: S/.%.2f%n",i+1,t*p[i]);\n    }\n}', calcular:function(v){let t=parseFloat(v.dinero),p=[0.30,0.25,0.20,0.15,0.10],r='';p.forEach((x,i)=>r+='Hijo '+(i+1)+': S/.'+(t*x).toFixed(2)+'\n');return r;} },
            '01_10': { inputs: [{label:'STAND (S/)', id:'stand', val:'500'},{label:'PUBLICIDAD (S/)', id:'publi', val:'300'},{label:'PERSONAL (S/)', id:'personal', val:'400'}], codigo:'public class GastosFeria {\n    public static void main(String[] args) {\n        double s=VALOR_STAND, p=VALOR_PUBLI, pe=VALOR_PERSONAL;\n        System.out.printf("Total: S/.%.2f%n",s+p+pe);\n    }\n}', calcular:function(v){let t=parseFloat(v.stand)+parseFloat(v.publi)+parseFloat(v.personal);return'Total: S/.'+t.toFixed(2);} },
            
            // SEMANA 2 (6 ejercicios)
            '02_1': { inputs: [{label:'MONTO DE COMPRA (S/)', id:'monto', val:'100'}], codigo:'public class Descuento11 {\n    public static void main(String[] args) {\n        double monto = VALOR_MONTO;\n        double desc = monto * 0.11;\n        double total = monto - desc;\n        System.out.printf("Descuento: S/.%.2f%n", desc);\n        System.out.printf("Total: S/.%.2f%n", total);\n        System.out.println("Obsequio: 3 caramelos");\n    }\n}', calcular:function(v){let m=parseFloat(v.monto),d=m*0.11;return'Descuento: S/.'+d.toFixed(2)+'\nTotal: S/.'+(m-d).toFixed(2)+'\nObsequio: 3 caramelos';} },
            '02_2': { inputs: [{label:'MONTO DE COMPRA (S/)', id:'monto', val:'200'}], codigo:'public class DobleDescuento {\n    public static void main(String[] args) {\n        double m = VALOR_MONTO;\n        double d1 = m * 0.07;\n        double m1 = m - d1;\n        double d2 = m1 * 0.07;\n        double total = m1 - d2;\n        System.out.printf("Total: S/.%.2f%n", total);\n    }\n}', calcular:function(v){let m=parseFloat(v.monto),d1=m*0.07,m1=m-d1,d2=m1*0.07;return'Descuento 1: S/.'+d1.toFixed(2)+'\nDescuento 2: S/.'+d2.toFixed(2)+'\nTotal: S/.'+(m1-d2).toFixed(2);} },
            '02_3': { inputs: [{label:'SUELDO BASE (S/)', id:'sueldo', val:'1500'}], codigo:'public class PagoMensual {\n    public static void main(String[] args) {\n        double s = VALOR_SUELDO;\n        double bonif = s * 0.20;\n        double desc = s * 0.10;\n        double total = s + bonif - desc;\n        System.out.printf("Total: S/.%.2f%n", total);\n    }\n}', calcular:function(v){let s=parseFloat(v.sueldo),b=s*0.20,d=s*0.10;return'Bonificacion: S/.'+b.toFixed(2)+'\nDescuento: S/.'+d.toFixed(2)+'\nTotal: S/.'+(s+b-d).toFixed(2);} },
            '02_4': { inputs: [{label:'MONTO DE COMPRA (S/)', id:'monto', val:'500'}], codigo:'public class DonacionHospital {\n    public static void main(String[] args) {\n        double m = VALOR_MONTO;\n        double don = m * 0.05;\n        System.out.printf("Donacion: S/.%.2f%n", don);\n    }\n}', calcular:function(v){let m=parseFloat(v.monto);return'Donacion al hospital: S/.'+(m*0.05).toFixed(2);} },
            '02_5': { inputs: [{label:'TOTAL VENTAS (S/)', id:'ventas', val:'5000'}], codigo:'public class SueldoVendedores {\n    public static void main(String[] args) {\n        double ventas = VALOR_VENTAS;\n        double sueldo = 300 + (ventas * 0.09);\n        System.out.printf("Sueldo: S/.%.2f%n", sueldo);\n    }\n}', calcular:function(v){let ve=parseFloat(v.ventas);return'Sueldo base: S/.300\nComision (9%): S/.'+(ve*0.09).toFixed(2)+'\nTotal: S/.'+(300+ve*0.09).toFixed(2);} },
            '02_6': { inputs: [{label:'SUELDO BRUTO (S/)', id:'bruto', val:'2000'}], codigo:'public class SueldoESSALUD {\n    public static void main(String[] args) {\n        double bruto = VALOR_BRUTO;\n        double essalud = bruto * 0.09;\n        double afp = bruto * 0.10;\n        double neto = bruto - essalud - afp;\n        System.out.printf("ESSALUD: S/.%.2f%n", essalud);\n        System.out.printf("AFP: S/.%.2f%n", afp);\n        System.out.printf("Neto: S/.%.2f%n", neto);\n    }\n}', calcular:function(v){let b=parseFloat(v.bruto),e=b*0.09,a=b*0.10;return'ESSALUD (9%): S/.'+e.toFixed(2)+'\nAFP (10%): S/.'+a.toFixed(2)+'\nNeto: S/.'+(b-e-a).toFixed(2);} },

            // SEMANA 3 (6 ejercicios)
            '03_1': { inputs: [{label:'MONTO DE COMPRA (S/)', id:'monto', val:'150'}], codigo:'public class Descuento11V2 {\n    public static void main(String[] args) {\n        double m = VALOR_MONTO;\n        double desc = m * 0.11;\n        System.out.printf("Descuento: S/.%.2f%n", desc);\n        System.out.printf("Total: S/.%.2f%n", m-desc);\n        System.out.println("Obsequio: caramelos");\n    }\n}', calcular:function(v){let m=parseFloat(v.monto),d=m*0.11;return'Descuento: S/.'+d.toFixed(2)+'\nTotal: S/.'+(m-d).toFixed(2)+'\nObsequio: caramelos';} },
            '03_2': { inputs: [{label:'MONTO DE COMPRA (S/)', id:'monto', val:'200'}], codigo:'public class Descuento10x2 {\n    public static void main(String[] args) {\n        double m = VALOR_MONTO;\n        double d1 = m * 0.10;\n        double m1 = m - d1;\n        double d2 = m1 * 0.10;\n        System.out.printf("Total: S/.%.2f%n", m1-d2);\n    }\n}', calcular:function(v){let m=parseFloat(v.monto),d1=m*0.10,m1=m-d1,d2=m1*0.10;return'Descuento 1: S/.'+d1.toFixed(2)+'\nDescuento 2: S/.'+d2.toFixed(2)+'\nTotal: S/.'+(m1-d2).toFixed(2);} },
            '03_3': { inputs: [{label:'SUELDO BASE (S/)', id:'sueldo', val:'2000'}], codigo:'public class SueldoEmpleado {\n    public static void main(String[] args) {\n        double s = VALOR_SUELDO;\n        double bonif = s * 0.20;\n        double desc = s * 0.10;\n        System.out.printf("Neto: S/.%.2f%n", s+bonif-desc);\n    }\n}', calcular:function(v){let s=parseFloat(v.sueldo);return'Bonificacion: S/.'+(s*0.20).toFixed(2)+'\nDescuento: S/.'+(s*0.10).toFixed(2)+'\nNeto: S/.'+(s*1.10).toFixed(2);} },
            '03_4': { inputs: [{label:'PASAJES (S/)', id:'pasajes', val:'50'}], codigo:'public class Transporte {\n    public static void main(String[] args) {\n        double p = VALOR_PASAJES;\n        double desc = p * 0.07;\n        System.out.printf("Descuento: S/.%.2f%n", desc);\n        System.out.println("Obsequio: chocolates");\n    }\n}', calcular:function(v){let p=parseFloat(v.pasajes);return'Descuento: S/.'+(p*0.07).toFixed(2)+'\nObsequio: chocolates';} },
            '03_5': { inputs: [{label:'VENTAS (S/)', id:'ventas', val:'8000'}], codigo:'public class SueldoVendedor {\n    public static void main(String[] args) {\n        double v = VALOR_VENTAS;\n        double sueldo = 300 + (v * 0.09) - (v * 0.11);\n        System.out.printf("Sueldo: S/.%.2f%n", sueldo);\n    }\n}', calcular:function(v){let ve=parseFloat(v.ventas);return'Base: S/.300\nComision: S/.'+(ve*0.09).toFixed(2)+'\nDescuento: S/.'+(ve*0.11).toFixed(2)+'\nTotal: S/.'+(300+ve*0.09-ve*0.11).toFixed(2);} },
            '03_6': { inputs: [{label:'SUELDO BRUTO (S/)', id:'bruto', val:'2500'}], codigo:'public class ESSALUD_AFP {\n    public static void main(String[] args) {\n        double b = VALOR_BRUTO;\n        System.out.printf("ESSALUD: S/.%.2f%n", b*0.09);\n        System.out.printf("AFP: S/.%.2f%n", b*0.10);\n        System.out.printf("Neto: S/.%.2f%n", b*0.81);\n    }\n}', calcular:function(v){let b=parseFloat(v.bruto);return'ESSALUD: S/.'+(b*0.09).toFixed(2)+'\nAFP: S/.'+(b*0.10).toFixed(2)+'\nNeto: S/.'+(b*0.81).toFixed(2);} },

            // SEMANA 4 (4 ejercicios)
            '04_1': { inputs: [{label:'TIPO (1,2,3)', id:'tipo', val:'1'},{label:'KM RECORRIDOS', id:'km', val:'150'}], codigo:'public class RentaCar {\n    public static void main(String[] args) {\n        int tipo = VALOR_TIPO;\n        double km = VALOR_KM;\n        double[] precios = {0,50,70,100};\n        double total = precios[tipo] + (km>100?(km-100)*0.5:0);\n        System.out.printf("Total: S/.%.2f%n", total);\n    }\n}', calcular:function(v){let t=parseInt(v.tipo),km=parseFloat(v.km),p=[0,50,70,100];let total=p[t]+(km>100?(km-100)*0.5:0);return'Tipo: '+t+'\nTotal: S/.'+total.toFixed(2);} },
            '04_2': { inputs: [{label:'HORAS TRABAJADAS', id:'horas', val:'50'},{label:'PAGO POR HORA', id:'pago', val:'20'}], codigo:'public class HorasExtras {\n    public static void main(String[] args) {\n        int h = VALOR_HORAS;\n        double p = VALOR_PAGO;\n        double total = h<=40 ? h*p : 40*p + (h-40)*p*2;\n        System.out.printf("Total: S/.%.2f%n", total);\n    }\n}', calcular:function(v){let h=parseInt(v.horas),p=parseFloat(v.pago);let total=h<=40?h*p:40*p+(h-40)*p*2;return'Total: S/.'+total.toFixed(2);} },
            '04_3': { inputs: [{label:'DIA (1=Lunes...)', id:'dia', val:'1'},{label:'HORAS', id:'horas', val:'3'}], codigo:'public class Estacionamiento {\n    public static void main(String[] args) {\n        int dia = VALOR_DIA, h = VALOR_HORAS;\n        double tarifa = (dia<=5) ? 5 : 8;\n        System.out.printf("Total: S/.%.2f%n", tarifa*h);\n    }\n}', calcular:function(v){let d=parseInt(v.dia),h=parseInt(v.horas),t=(d<=5)?5:8;return'Tarifa: S/.'+t+'\nTotal: S/.'+(t*h).toFixed(2);} },
            '04_4': { inputs: [{label:'NOTA 1', id:'n1', val:'14'},{label:'NOTA 2', id:'n2', val:'15'},{label:'NOTA 3', id:'n3', val:'16'}], codigo:'public class PromedioNotas {\n    public static void main(String[] args) {\n        double n1=VALOR_N1, n2=VALOR_N2, n3=VALOR_N3+2;\n        double prom = (n1+n2+n3)/3;\n        System.out.printf("Promedio: %.2f%n", prom);\n    }\n}', calcular:function(v){let n1=parseFloat(v.n1),n2=parseFloat(v.n2),n3=parseFloat(v.n3)+2;return'Nota 1: '+n1+'\nNota 2: '+n2+'\nNota 3: '+n3+' (+2 bonus)\nPromedio: '+((n1+n2+n3)/3).toFixed(2);} },

            // SEMANA 5 (6 ejercicios)
            '05_1': { inputs: [{label:'N (terminos)', id:'n', val:'5'}], codigo:'public class SerieAritmetica {\n    public static void main(String[] args) {\n        int n = VALOR_N, t = 3, suma = 0;\n        for(int i=0;i<n;i++) { suma += t; t += 7; }\n        System.out.println("Suma: " + suma);\n    }\n}', calcular:function(v){let n=parseInt(v.n),t=3,s=0,r='';for(let i=0;i<n;i++){s+=t;r+=t+' ';t+=7;}return'Serie: '+r+'\nSuma: '+s;} },
            '05_2': { inputs: [{label:'N (terminos)', id:'n', val:'5'}], codigo:'public class SerieFraccionaria {\n    public static void main(String[] args) {\n        int n = VALOR_N;\n        double num=2, den=5, suma=0;\n        for(int i=0;i<n;i++) { suma+=num/den; num+=3; den+=4; }\n        System.out.printf("Suma: %.4f%n", suma);\n    }\n}', calcular:function(v){let n=parseInt(v.n),num=2,den=5,s=0,r='';for(let i=0;i<n;i++){s+=num/den;r+=num+'/'+den+' ';num+=3;den+=4;}return'Serie: '+r+'\nSuma: '+s.toFixed(4);} },
            '05_3': { inputs: [{label:'NUMERO', id:'num', val:'2468'}], codigo:'public class DigitosNumero {\n    public static void main(String[] args) {\n        int n = VALOR_NUM, sp=0, si=0, c=0;\n        while(n>0){ int d=n%10; c++; if(d%2==0)sp+=d; else si+=d; n/=10; }\n        System.out.println("Cantidad: "+c+" SumaP: "+sp+" SumaI: "+si);\n    }\n}', calcular:function(v){let n=parseInt(v.num),sp=0,si=0,c=0;while(n>0){let d=n%10;c++;d%2==0?sp+=d:si+=d;n=Math.floor(n/10);}return'Cantidad: '+c+'\nSuma Pares: '+sp+'\nSuma Impares: '+si;} },
            '05_4': { inputs: [{label:'N (terminos)', id:'n', val:'5'}], codigo:'public class SerieFactorial {\n    public static void main(String[] args) {\n        int n=VALOR_N,i=1; double s=0,f=1;\n        do{ f*=i; s+=(i%2==0)?-1.0/f:1.0/f; i++; }while(i<=n);\n        System.out.printf("Suma: %.6f%n", s);\n    }\n}', calcular:function(v){let n=parseInt(v.n),i=1,s=0,f=1;do{f*=i;s+=(i%2==0)?-1/f:1/f;i++;}while(i<=n);return'Suma: '+s.toFixed(6);} },
            '05_5': { inputs: [{label:'PRODUCTO (1-4)', id:'prod', val:'1'},{label:'CANTIDAD', id:'cant', val:'3'}], codigo:'public class VentaCuadernos {\n    public static void main(String[] args) {\n        int p=VALOR_PROD, c=VALOR_CANT;\n        double[] precios={0,5,8,12,15};\n        System.out.printf("Total: S/.%.2f%n", precios[p]*c);\n    }\n}', calcular:function(v){let p=parseInt(v.prod),c=parseInt(v.cant),pr=[0,5,8,12,15];return'Producto: '+p+'\nTotal: S/.'+(pr[p]*c).toFixed(2);} },
            '05_6': { inputs: [{label:'N PRODUCTOS', id:'n', val:'5'}], codigo:'public class StockAleatorio {\n    public static void main(String[] args) {\n        int n = VALOR_N;\n        for(int i=0;i<n;i++){\n            int stock = (int)(Math.random()*100);\n            String r = stock<30?"BAJO":stock<70?"MEDIO":"ALTO";\n            System.out.println("P"+(i+1)+": "+stock+" ("+r+")");\n        }\n    }\n}', calcular:function(v){let n=parseInt(v.n),r='';for(let i=0;i<n;i++){let s=Math.floor(Math.random()*100),c=s<30?'BAJO':s<70?'MEDIO':'ALTO';r+='P'+(i+1)+': '+s+' ('+c+')\n';}return r;} },

            // SEMANA 6 (3 ejercicios)
            '06_1': { inputs: [{label:'CANTIDAD DE CHOCOLATES', id:'cant', val:'10'}], codigo:'public class DulcePorvenir {\n    public static void main(String[] args) {\n        int c = VALOR_CANT;\n        double precio = c>12?c*1.5:c*2;\n        System.out.printf("Total: S/.%.2f%n", precio);\n        if(c>12) System.out.println("Obsequio: 2 caramelos");\n    }\n}', calcular:function(v){let c=parseInt(v.cant),p=c>12?c*1.5:c*2,r='Total: S/.'+p.toFixed(2);if(c>12)r+='\nObsequio: 2 caramelos';return r;} },
            '06_2': { inputs: [{label:'BOLETOS', id:'cant', val:'5'},{label:'CALIDAD (A/B)', id:'calidad', val:'A'}], codigo:'public class AngelitoAzules {\n    public static void main(String[] args) {\n        int c=VALOR_CANT; char cal=VALOR_CALIDAD.charAt(0);\n        double p=cal==A?50:40, total=c*p;\n        if(c>4) total*=0.85;\n        System.out.printf("Total: S/.%.2f%n", total);\n    }\n}', calcular:function(v){let c=parseInt(v.cant),cal=v.calidad.toUpperCase(),p=cal==='A'?50:40,t=c*p;if(c>4)t*=0.85;return'Calidad: '+cal+'\nPrecio: S/.'+p+'\nTotal: S/.'+t.toFixed(2);} },
            '06_3': { inputs: [{label:'EDAD', id:'edad', val:'25'},{label:'NIVEL (1-3)', id:'nivel', val:'2'}], codigo:'public class LibretasMilitares {\n    public static void main(String[] args) {\n        int e=VALOR_EDAD, n=VALOR_NIVEL;\n        double d = (e<25?0.30:e<35?0.20:0.10) + (n==1?0.10:n==2?0.05:0);\n        System.out.printf("Descuento: %.0f%%%n", d*100);\n    }\n}', calcular:function(v){let e=parseInt(v.edad),n=parseInt(v.nivel),d=(e<25?0.30:e<35?0.20:0.10)+(n===1?0.10:n===2?0.05:0);return'Edad: '+e+'\nNivel: '+n+'\nDescuento: '+(d*100)+'%';} },

            // SEMANA 7 (10 ejercicios)
            '07_1': { inputs: [{label:'TEXTO', id:'texto', val:'Hola Mundo'}], codigo:'public class ContadorVocales {\n    public static void main(String[] args) {\n        String t = VALOR_TEXTO.toLowerCase();\n        int c = 0;\n        for(int i=0;i<t.length();i++){\n            char ch=t.charAt(i);\n            if("aeiou".indexOf(ch)>=0) c++;\n        }\n        System.out.println("Vocales: " + c);\n    }\n}', calcular:function(v){let t=v.texto.toLowerCase(),c=0;for(let ch of t){if('aeiou'.includes(ch))c++;}return'Texto: '+v.texto+'\nVocales: '+c;} },
            '07_2': { inputs: [{label:'TEXTO', id:'texto', val:'Java'}], codigo:'public class InversorCadenas {\n    public static void main(String[] args) {\n        String t = VALOR_TEXTO, inv = "";\n        for(int i=t.length()-1;i>=0;i--) inv+=t.charAt(i);\n        System.out.println("Invertido: " + inv);\n    }\n}', calcular:function(v){let t=v.texto,inv='';for(let i=t.length-1;i>=0;i--)inv+=t[i];return'Original: '+t+'\nInvertido: '+inv;} },
            '07_3': { inputs: [{label:'EMAIL', id:'email', val:'test@gmail.com'}], codigo:'public class ValidadorCorreos {\n    public static void main(String[] args) {\n        String e = VALOR_EMAIL;\n        boolean ok = e.contains("@") && e.indexOf("@")>0 && e.endsWith(".com");\n        System.out.println(ok ? "Valido" : "Invalido");\n    }\n}', calcular:function(v){let e=v.email;return e.includes('@')&&e.indexOf('@')>0&&e.endsWith('.com')?'Valido':'Invalido';} },
            '07_4': { inputs: [{label:'TARJETA', id:'tarjeta', val:'1234567890123456'}], codigo:'public class Enmascarador {\n    public static void main(String[] args) {\n        String t = VALOR_TARJETA;\n        System.out.println("****"+t.substring(t.length()-4));\n    }\n}', calcular:function(v){let t=v.tarjeta;return'****'+t.slice(-4);} },
            '07_5': { inputs: [{label:'NOMBRE COMPLETO', id:'nombre', val:'juan perez'}], codigo:'public class AnalizadorNombres {\n    public static void main(String[] args) {\n        String[] p = VALOR_NOMBRE.split(" ");\n        for(String s : p)\n            System.out.print(s.substring(0,1).toUpperCase()+s.substring(1)+" ");\n    }\n}', calcular:function(v){return v.nombre.split(' ').map(s=>s.charAt(0).toUpperCase()+s.slice(1)).join(' ');} },
            '07_6': { inputs: [{label:'TEXTO', id:'texto', val:'anita lava la tina'}], codigo:'public class Palindromo {\n    public static void main(String[] args) {\n        String t = VALOR_TEXTO.replace(" ","").toLowerCase();\n        String inv = new StringBuilder(t).reverse().toString();\n        System.out.println(t.equals(inv)?"Palindromo":"No palindromo");\n    }\n}', calcular:function(v){let t=v.texto.replace(/\s/g,'').toLowerCase();let inv=t.split('').reverse().join('');return t===inv?'Palindromo':'No palindromo';} },
            '07_7': { inputs: [{label:'TEXTO', id:'texto', val:'Eres un tonto'}], codigo:'public class Censor {\n    public static void main(String[] args) {\n        String t = VALOR_TEXTO;\n        t = t.replaceAll("tonto","****").replaceAll("malo","****");\n        System.out.println(t);\n    }\n}', calcular:function(v){return v.texto.replace(/tonto|malo/gi,'****');} },
            '07_8': { inputs: [{label:'URL', id:'url', val:'https://www.google.com'}], codigo:'public class ExtractorDominios {\n    public static void main(String[] args) {\n        String u = VALOR_URL;\n        int i = u.indexOf("//")+2;\n        int f = u.indexOf("/",i);\n        System.out.println(u.substring(i,f>0?f:u.length()));\n    }\n}', calcular:function(v){let u=v.url,i=u.indexOf('//')+2,f=u.indexOf('/',i);return u.substring(i,f>0?f:u.length);} },
            '07_9': { inputs: [{label:'TEXTO CON ESPACIOS', id:'texto', val:'   Hola   '}], codigo:'public class LimpiadorFormularios {\n    public static void main(String[] args) {\n        String t = VALOR_TEXTO.trim().replaceAll("\\\\s+"," ");\n        System.out.println("'" + t + "'");\n    }\n}', calcular:function(v){return "'"+v.texto.trim().replace(/\s+/g,' ')+"'";} },
            '07_10': { inputs: [{label:'TEXTO', id:'texto', val:'Hola mundo cruel'}], codigo:'public class ContadorPalabras {\n    public static void main(String[] args) {\n        String t = VALOR_TEXTO.trim();\n        int c = t.isEmpty()?0:t.split("\\\\s+").length;\n        System.out.println("Palabras: " + c);\n    }\n}', calcular:function(v){let t=v.texto.trim();return t?t.split(/\s+/).length:0;} },

            // SEMANA 8 (2 ejercicios)
            '08_1': { inputs: [{label:'RADIO (cm)', id:'radio', val:'5'}], codigo:'public class AreaCirculoMath {\n    public static void main(String[] args) {\n        double r = VALOR_RADIO;\n        System.out.printf("Area: %.2f cm2%n", Math.PI*Math.pow(r,2));\n    }\n}', calcular:function(v){let r=parseFloat(v.radio);return'Area: '+(Math.PI*Math.pow(r,2)).toFixed(2)+' cm2';} },
            '08_2': { inputs: [{label:'CATETO A', id:'a', val:'3'},{label:'CATETO B', id:'b', val:'4'}], codigo:'public class PitagorasExpress {\n    public static void main(String[] args) {\n        System.out.printf("Hipotenusa: %.2f%n", Math.hypot(VALOR_A,VALOR_B));\n    }\n}', calcular:function(v){return'Hipotenusa: '+Math.hypot(parseFloat(v.a),parseFloat(v.b)).toFixed(2);} },

            // SEMANA 9 (2 ejercicios)
            '09_1': { inputs: [{label:'CARAS DEL DADO', id:'caras', val:'20'}], codigo:'public class SimuladorDados {\n    public static void main(String[] args) {\n        int c = VALOR_CARAS;\n        System.out.println("Tirada: " + ((int)(Math.random()*c)+1));\n    }\n}', calcular:function(v){let c=parseInt(v.caras);return'Tirada: '+(Math.floor(Math.random()*c)+1);} },
            '09_2': { inputs: [{label:'A', id:'a', val:'1'},{label:'B', id:'b', val:'-3'},{label:'C', id:'c', val:'2'}], codigo:'public class EcuacionesCuadraticas {\n    public static void main(String[] args) {\n        double a=VALOR_A,b=VALOR_B,c=VALOR_C;\n        double d=b*b-4*a*c;\n        if(d>=0) System.out.printf("x1=%.2f x2=%.2f%n",(-b+Math.sqrt(d))/(2*a),(-b-Math.sqrt(d))/(2*a));\n        else System.out.println("Sin solucion real");\n    }\n}', calcular:function(v){let a=parseFloat(v.a),b=parseFloat(v.b),c=parseFloat(v.c),d=b*b-4*a*c;if(d>=0){return'x1= '+((-b+Math.sqrt(d))/(2*a)).toFixed(2)+'\nx2= '+((-b-Math.sqrt(d))/(2*a)).toFixed(2);}return'Sin solucion real';} },

            // SEMANA 10 (2 ejercicios)
            '10_1': { inputs: [{label:'GRADOS', id:'grados', val:'90'}], codigo:'public class ConversorTrigonometrico {\n    public static void main(String[] args) {\n        double g = VALOR_GRADOS;\n        double r = Math.toRadians(g);\n        System.out.printf("Seno: %.4f%n", Math.sin(r));\n        System.out.printf("Coseno: %.4f%n", Math.cos(r));\n    }\n}', calcular:function(v){let r=parseFloat(v.grados)*Math.PI/180;return'Seno: '+Math.sin(r).toFixed(4)+'\nCoseno: '+Math.cos(r).toFixed(4);} },
            '10_2': { inputs: [{label:'NUMERO A', id:'a', val:'2147483647'},{label:'NUMERO B', id:'b', val:'1'}], codigo:'public class AntiDesbordamiento {\n    public static void main(String[] args) {\n        try {\n            System.out.println("Suma: "+Math.addExact(VALOR_A,VALOR_B));\n        } catch(ArithmeticException e) {\n            System.out.println("Desbordamiento!");\n        }\n    }\n}', calcular:function(v){let a=parseInt(v.a),b=parseInt(v.b);if(a>9007199254740991||b>9007199254740991)return'Desbordamiento!';return'Suma: '+(a+b);} },

            // SEMANA 11 (2 ejercicios)
            '11_1': { inputs: [{label:'CAPITAL (S/)', id:'capital', val:'1000'},{label:'TASA (%)', id:'tasa', val:'5'},{label:'AÑOS', id:'anos', val:'3'}], codigo:'public class InteresCompuesto {\n    public static void main(String[] args) {\n        double p=VALOR_CAPITAL, r=VALOR_TASA/100, t=VALOR_ANOS;\n        double m = p*Math.exp(r*t);\n        System.out.printf("Monto: S/.%.2f%n", m);\n    }\n}', calcular:function(v){let p=parseFloat(v.capital),r=parseFloat(v.tasa)/100,t=parseFloat(v.anos);return'Monto: S/.'+(p*Math.exp(r*t)).toFixed(2);} },
            '11_2': { inputs: [{label:'X1', id:'x1', val:'3'},{label:'Y1', id:'y1', val:'4'},{label:'X2', id:'x2', val:'7'},{label:'Y2', id:'y2', val:'1'}], codigo:'public class DistanciaEuclidiana {\n    public static void main(String[] args) {\n        double d=Math.sqrt(Math.pow(VALOR_X2-VALOR_X1,2)+Math.pow(VALOR_Y2-VALOR_Y1,2));\n        System.out.printf("Distancia: %.2f%n", d);\n    }\n}', calcular:function(v){let x1=parseFloat(v.x1),y1=parseFloat(v.y1),x2=parseFloat(v.x2),y2=parseFloat(v.y2);return'Distancia: '+Math.sqrt(Math.pow(x2-x1,2)+Math.pow(y2-y1,2)).toFixed(2);} }
        };
        
        const data = ejercicios[key];
        
        function init() {
            if (!data) {
                document.getElementById('inputs-container').innerHTML = '<p style="color:#9ca3af;">Ejercicio en desarrollo</p>';
                document.getElementById('codigo').textContent = '// Código próximamente...';
                return;
            }
            let html = '';
            data.inputs.forEach(inp => {
                html += '<div class="input-group"><label>'+inp.label+'</label><input type="number" id="'+inp.id+'" value="'+inp.val+'" step="any"></div>';
            });
            document.getElementById('inputs-container').innerHTML = html;
            actualizarCodigo();
        }
        
        function actualizarCodigo() {
            if (!data) return;
            let cod = data.codigo;
            data.inputs.forEach(inp => {
                let val = document.getElementById(inp.id) ? document.getElementById(inp.id).value : inp.val;
                cod = cod.replace(new RegExp('VALOR_'+inp.id.toUpperCase(), 'g'), val);
            });
            document.getElementById('codigo').textContent = cod;
        }
        
        function calcular() {
            if (!data) return;
            let valores = {};
            data.inputs.forEach(inp => {
                valores[inp.id] = document.getElementById(inp.id).value;
            });
            document.getElementById('resultado').textContent = data.calcular(valores);
            actualizarCodigo();
        }
        
        init();
    </script>
</body>
</html>