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
            // SEMANA 1 (10)
            '01_1': { inputs: [{label:'BASE (cm)', id:'base', val:'10'},{label:'ALTURA (cm)', id:'altura', val:'5'}], codigo:'public class Rectangulo {\n    public static void main(String[] args) {\n        double base = VALOR_BASE;\n        double altura = VALOR_ALTURA;\n        double area = base * altura;\n        double perimetro = 2 * (base + altura);\n        System.out.println("Area: " + area + " cm2");\n        System.out.println("Perimetro: " + perimetro + " cm");\n    }\n}', calcular:function(v){let b=parseFloat(v.base),a=parseFloat(v.altura);return'Base: '+b+' cm\nAltura: '+a+' cm\nArea: '+(b*a)+' cm2\nPerimetro: '+(2*(b+a))+' cm';} },
            '01_2': { inputs: [{label:'RADIO (cm)', id:'radio', val:'7'}], codigo:'public class Circulo {\n    public static void main(String[] args) {\n        double r = VALOR_RADIO;\n        double area = Math.PI * r * r;\n        double longi = 2 * Math.PI * r;\n        System.out.printf("Area: %.2f cm2%n", area);\n        System.out.printf("Longitud: %.2f cm%n", longi);\n    }\n}', calcular:function(v){let r=parseFloat(v.radio);return'Area: '+(Math.PI*r*r).toFixed(2)+' cm2\nLongitud: '+(2*Math.PI*r).toFixed(2)+' cm';} },
            '01_3': { inputs: [{label:'DIAGONAL MAYOR', id:'dm', val:'12'},{label:'DIAGONAL MENOR', id:'dmen', val:'8'}], codigo:'public class Rombo {\n    public static void main(String[] args) {\n        double D = VALOR_DM, d = VALOR_DMEN;\n        double area = (D * d) / 2;\n        System.out.println("Area: " + area + " cm2");\n    }\n}', calcular:function(v){let a=(parseFloat(v.dm)*parseFloat(v.dmen))/2;return'Area: '+a+' cm2';} },
            '01_4': { inputs: [{label:'RADIO (cm)', id:'radio', val:'5'},{label:'ALTURA (cm)', id:'altura', val:'10'}], codigo:'public class Cilindro {\n    public static void main(String[] args) {\n        double r = VALOR_RADIO, h = VALOR_ALTURA;\n        double area = 2 * Math.PI * r * (r + h);\n        double vol = Math.PI * r * r * h;\n        System.out.printf("Area: %.2f cm2%n", area);\n        System.out.printf("Volumen: %.2f cm3%n", vol);\n    }\n}', calcular:function(v){let r=parseFloat(v.radio),h=parseFloat(v.altura);return'Area: '+(2*Math.PI*r*(r+h)).toFixed(2)+' cm2\nVolumen: '+(Math.PI*r*r*h).toFixed(2)+' cm3';} },
            '01_5': { inputs: [{label:'LADO (cm)', id:'lado', val:'6'}], codigo:'public class Cubo {\n    public static void main(String[] args) {\n        double l = VALOR_LADO;\n        double area = 6 * l * l;\n        double vol = l * l * l;\n        System.out.println("Area: " + area + " cm2");\n        System.out.println("Volumen: " + vol + " cm3");\n    }\n}', calcular:function(v){let l=parseFloat(v.lado);return'Area: '+(6*l*l)+' cm2\nVolumen: '+(l*l*l)+' cm3';} },
            '01_6': { inputs: [{label:'DIVIDENDO', id:'a', val:'25'},{label:'DIVISOR', id:'b', val:'4'}], codigo:'public class DivisionEntera {\n    public static void main(String[] args) {\n        int a = VALOR_A, b = VALOR_B;\n        System.out.println("Cociente: " + (a/b));\n        System.out.println("Residuo: " + (a%b));\n    }\n}', calcular:function(v){let a=parseInt(v.a),b=parseInt(v.b);return'Cociente: '+Math.floor(a/b)+'\nResiduo: '+(a%b);} },
            '01_7': { inputs: [{label:'NÚMERO (5 dígitos)', id:'num', val:'12345'}], codigo:'public class NumeroInvertido {\n    public static void main(String[] args) {\n        int n = VALOR_NUM, inv = 0;\n        while (n > 0) { inv = inv * 10 + n % 10; n /= 10; }\n        System.out.println("Invertido: " + inv);\n    }\n}', calcular:function(v){let n=v.num,inv='';for(let i=n.length-1;i>=0;i--)inv+=n[i];return'Original: '+n+'\nInvertido: '+inv;} },
            '01_8': { inputs: [{label:'SEGUNDOS', id:'seg', val:'3665'}], codigo:'public class ConversionTiempo {\n    public static void main(String[] args) {\n        int t = VALOR_SEG;\n        int h = t/3600, m = (t%3600)/60, s = t%60;\n        System.out.println(h+"h "+m+"m "+s+"s");\n    }\n}', calcular:function(v){let t=parseInt(v.seg),h=Math.floor(t/3600),m=Math.floor((t%3600)/60),s=t%60;return h+'h '+m+'m '+s+'s';} },
            '01_9': { inputs: [{label:'DINERO TOTAL (S/)', id:'dinero', val:'1000'}], codigo:'public class RepartoDinero {\n    public static void main(String[] args) {\n        double t = VALOR_DINERO;\n        double[] p = {0.30,0.25,0.20,0.15,0.10};\n        for(int i=0;i<5;i++)\n            System.out.printf("Hijo %d: S/.%.2f%n",i+1,t*p[i]);\n    }\n}', calcular:function(v){let t=parseFloat(v.dinero),p=[0.30,0.25,0.20,0.15,0.10],r='';p.forEach((x,i)=>r+='Hijo '+(i+1)+': S/.'+(t*x).toFixed(2)+'\n');return r;} },
            '01_10': { inputs: [{label:'STAND (S/)', id:'stand', val:'500'},{label:'PUBLICIDAD (S/)', id:'publi', val:'300'},{label:'PERSONAL (S/)', id:'personal', val:'400'}], codigo:'public class GastosFeria {\n    public static void main(String[] args) {\n        double s=VALOR_STAND, p=VALOR_PUBLI, pe=VALOR_PERSONAL;\n        System.out.printf("Total: S/.%.2f%n",s+p+pe);\n    }\n}', calcular:function(v){let t=parseFloat(v.stand)+parseFloat(v.publi)+parseFloat(v.personal);return'Total: S/.'+t.toFixed(2);} },
            
            // SEMANA 2 (6)
            '02_1': { inputs: [{label:'MONTO (S/)', id:'monto', val:'100'}], codigo:'public class Descuento11 {\n    public static void main(String[] args) {\n        double m = VALOR_MONTO;\n        double d = m * 0.11;\n        System.out.printf("Desc: S/.%.2f%n", d);\n        System.out.printf("Total: S/.%.2f%n", m-d);\n        System.out.println("Obsequio: 3 caramelos");\n    }\n}', calcular:function(v){let m=parseFloat(v.monto),d=m*0.11;return'Descuento: S/.'+d.toFixed(2)+'\nTotal: S/.'+(m-d).toFixed(2)+'\nObsequio: 3 caramelos';} },
            '02_2': { inputs: [{label:'MONTO (S/)', id:'monto', val:'200'}], codigo:'public class DobleDescuento {\n    public static void main(String[] args) {\n        double m = VALOR_MONTO;\n        double d1 = m * 0.07;\n        double m1 = m - d1;\n        double d2 = m1 * 0.07;\n        System.out.printf("Total: S/.%.2f%n", m1-d2);\n    }\n}', calcular:function(v){let m=parseFloat(v.monto),d1=m*0.07,m1=m-d1,d2=m1*0.07;return'Desc 1: S/.'+d1.toFixed(2)+'\nDesc 2: S/.'+d2.toFixed(2)+'\nTotal: S/.'+(m1-d2).toFixed(2);} },
            '02_3': { inputs: [{label:'SUELDO (S/)', id:'sueldo', val:'1500'}], codigo:'public class PagoMensual {\n    public static void main(String[] args) {\n        double s = VALOR_SUELDO;\n        double b = s * 0.20, d = s * 0.10;\n        System.out.printf("Total: S/.%.2f%n", s+b-d);\n    }\n}', calcular:function(v){let s=parseFloat(v.sueldo);return'Bonif: S/.'+(s*0.20).toFixed(2)+'\nDesc: S/.'+(s*0.10).toFixed(2)+'\nTotal: S/.'+(s*1.10).toFixed(2);} },
            '02_4': { inputs: [{label:'MONTO (S/)', id:'monto', val:'500'}], codigo:'public class Donacion {\n    public static void main(String[] args) {\n        double m = VALOR_MONTO;\n        System.out.printf("Donacion: S/.%.2f%n", m*0.05);\n    }\n}', calcular:function(v){let m=parseFloat(v.monto);return'Donacion: S/.'+(m*0.05).toFixed(2);} },
            '02_5': { inputs: [{label:'VENTAS (S/)', id:'ventas', val:'5000'}], codigo:'public class SueldoVendedores {\n    public static void main(String[] args) {\n        double v = VALOR_VENTAS;\n        double s = 300 + v * 0.09;\n        System.out.printf("Sueldo: S/.%.2f%n", s);\n    }\n}', calcular:function(v){let ve=parseFloat(v.ventas);return'Base: S/.300\nComision: S/.'+(ve*0.09).toFixed(2)+'\nTotal: S/.'+(300+ve*0.09).toFixed(2);} },
            '02_6': { inputs: [{label:'BRUTO (S/)', id:'bruto', val:'2000'}], codigo:'public class ESSALUD_AFP {\n    public static void main(String[] args) {\n        double b = VALOR_BRUTO;\n        double e = b*0.09, a = b*0.10;\n        System.out.printf("ESSALUD: S/.%.2f%n", e);\n        System.out.printf("AFP: S/.%.2f%n", a);\n        System.out.printf("Neto: S/.%.2f%n", b-e-a);\n    }\n}', calcular:function(v){let b=parseFloat(v.bruto),e=b*0.09,a=b*0.10;return'ESSALUD: S/.'+e.toFixed(2)+'\nAFP: S/.'+a.toFixed(2)+'\nNeto: S/.'+(b-e-a).toFixed(2);} },

            // SEMANA 3 (6)
            '03_1': { inputs: [{label:'MONTO (S/)', id:'monto', val:'150'}], codigo:'public class Descuento11V2 {\n    public static void main(String[] args) {\n        double m = VALOR_MONTO;\n        double d = m * 0.11;\n        System.out.printf("Desc: S/.%.2f%n", d);\n        System.out.printf("Total: S/.%.2f%n", m-d);\n        System.out.println("Obsequio: caramelos");\n    }\n}', calcular:function(v){let m=parseFloat(v.monto),d=m*0.11;return'Descuento: S/.'+d.toFixed(2)+'\nTotal: S/.'+(m-d).toFixed(2)+'\nObsequio: caramelos';} },
            '03_2': { inputs: [{label:'MONTO (S/)', id:'monto', val:'200'}], codigo:'public class DobleDesc10 {\n    public static void main(String[] args) {\n        double m = VALOR_MONTO;\n        double d1 = m * 0.10;\n        double m1 = m - d1;\n        double d2 = m1 * 0.10;\n        System.out.printf("Total: S/.%.2f%n", m1-d2);\n    }\n}', calcular:function(v){let m=parseFloat(v.monto),d1=m*0.10,m1=m-d1,d2=m1*0.10;return'Desc 1: S/.'+d1.toFixed(2)+'\nDesc 2: S/.'+d2.toFixed(2)+'\nTotal: S/.'+(m1-d2).toFixed(2);} },
            '03_3': { inputs: [{label:'SUELDO (S/)', id:'sueldo', val:'2000'}], codigo:'public class SueldoEmpleado {\n    public static void main(String[] args) {\n        double s = VALOR_SUELDO;\n        double b = s * 0.20, d = s * 0.10;\n        System.out.printf("Neto: S/.%.2f%n", s+b-d);\n    }\n}', calcular:function(v){let s=parseFloat(v.sueldo);return'Bonif: S/.'+(s*0.20).toFixed(2)+'\nDesc: S/.'+(s*0.10).toFixed(2)+'\nNeto: S/.'+(s*1.10).toFixed(2);} },
            '03_4': { inputs: [{label:'PASAJES (S/)', id:'pasajes', val:'50'}], codigo:'public class Transporte {\n    public static void main(String[] args) {\n        double p = VALOR_PASAJES;\n        System.out.printf("Desc: S/.%.2f%n", p*0.07);\n        System.out.println("Obsequio: chocolates");\n    }\n}', calcular:function(v){return'Descuento: S/.'+(parseFloat(v.pasajes)*0.07).toFixed(2)+'\nObsequio: chocolates';} },
            '03_5': { inputs: [{label:'VENTAS (S/)', id:'ventas', val:'8000'}], codigo:'public class SueldoVendedor {\n    public static void main(String[] args) {\n        double v = VALOR_VENTAS;\n        double s = 300 + v*0.09 - v*0.11;\n        System.out.printf("Sueldo: S/.%.2f%n", s);\n    }\n}', calcular:function(v){let ve=parseFloat(v.ventas);return'Base: S/.300\nComision: S/.'+(ve*0.09).toFixed(2)+'\nDesc: S/.'+(ve*0.11).toFixed(2)+'\nTotal: S/.'+(300+ve*0.09-ve*0.11).toFixed(2);} },
            '03_6': { inputs: [{label:'BRUTO (S/)', id:'bruto', val:'2500'}], codigo:'public class ESSALUD_AFP2 {\n    public static void main(String[] args) {\n        double b = VALOR_BRUTO;\n        System.out.printf("ESSALUD: S/.%.2f%n", b*0.09);\n        System.out.printf("AFP: S/.%.2f%n", b*0.10);\n        System.out.printf("Neto: S/.%.2f%n", b*0.81);\n    }\n}', calcular:function(v){let b=parseFloat(v.bruto);return'ESSALUD: S/.'+(b*0.09).toFixed(2)+'\nAFP: S/.'+(b*0.10).toFixed(2)+'\nNeto: S/.'+(b*0.81).toFixed(2);} },

            // SEMANA 4 (4)
            '04_1': { inputs: [{label:'TIPO (1,2,3)', id:'tipo', val:'1'},{label:'KM RECORRIDOS', id:'km', val:'150'}], codigo:'public class RentaCar {\n    public static void main(String[] args) {\n        int t = VALOR_TIPO;\n        double km = VALOR_KM;\n        double[] p = {0,50,70,100};\n        double total = p[t] + (km>100?(km-100)*0.5:0);\n        System.out.printf("Total: S/.%.2f%n", total);\n    }\n}', calcular:function(v){let t=parseInt(v.tipo),km=parseFloat(v.km),p=[0,50,70,100];let total=p[t]+(km>100?(km-100)*0.5:0);return'Tipo: '+t+'\nTotal: S/.'+total.toFixed(2);} },
            '04_2': { inputs: [{label:'HORAS TRABAJADAS', id:'horas', val:'50'},{label:'PAGO POR HORA', id:'pago', val:'20'}], codigo:'public class HorasExtras {\n    public static void main(String[] args) {\n        int h = VALOR_HORAS;\n        double p = VALOR_PAGO;\n        double total = h<=40 ? h*p : 40*p + (h-40)*p*2;\n        System.out.printf("Total: S/.%.2f%n", total);\n    }\n}', calcular:function(v){let h=parseInt(v.horas),p=parseFloat(v.pago);let total=h<=40?h*p:40*p+(h-40)*p*2;return'Total: S/.'+total.toFixed(2);} },
            '04_3': { inputs: [{label:'DIA (1=Lunes,7=Domingo)', id:'dia', val:'1'},{label:'HORAS', id:'horas', val:'3'}], codigo:'public class Estacionamiento {\n    public static void main(String[] args) {\n        int dia = VALOR_DIA, h = VALOR_HORAS;\n        double tarifa = (dia<=5) ? 5 : 8;\n        System.out.printf("Total: S/.%.2f%n", tarifa*h);\n    }\n}', calcular:function(v){let d=parseInt(v.dia),h=parseInt(v.horas),t=(d<=5)?5:8;return'Tarifa: S/.'+t+'\nTotal: S/.'+(t*h).toFixed(2);} },
            '04_4': { inputs: [{label:'NOTA 1', id:'n1', val:'14'},{label:'NOTA 2', id:'n2', val:'15'},{label:'NOTA 3', id:'n3', val:'16'}], codigo:'public class PromedioNotas {\n    public static void main(String[] args) {\n        double n1=VALOR_N1, n2=VALOR_N2, n3=VALOR_N3+2;\n        double prom = (n1+n2+n3)/3;\n        System.out.printf("Promedio: %.2f%n", prom);\n    }\n}', calcular:function(v){let n1=parseFloat(v.n1),n2=parseFloat(v.n2),n3=parseFloat(v.n3)+2;return'Nota 1: '+n1+'\nNota 2: '+n2+'\nNota 3: '+n3+' (+2 bonus)\nPromedio: '+((n1+n2+n3)/3).toFixed(2);} }
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