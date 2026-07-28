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
            '01_1': { inputs: [{label:'BASE (cm)', id:'base', val:'10'},{label:'ALTURA (cm)', id:'altura', val:'5'}], codigo:'public class Rectangulo {\n    public static void main(String[] args) {\n        double base = VALOR_BASE;\n        double altura = VALOR_ALTURA;\n        double area = base * altura;\n        double perimetro = 2 * (base + altura);\n        System.out.println("Base: " + base + " cm");\n        System.out.println("Altura: " + altura + " cm");\n        System.out.println("Area: " + area + " cm2");\n        System.out.println("Perimetro: " + perimetro + " cm");\n    }\n}', calcular:function(v){let b=parseFloat(v.base),a=parseFloat(v.altura);return'Base: '+b+' cm\nAltura: '+a+' cm\nArea: '+(b*a)+' cm2\nPerimetro: '+(2*(b+a))+' cm';} },
            '01_2': { inputs: [{label:'RADIO (cm)', id:'radio', val:'7'}], codigo:'public class Circulo {\n    public static void main(String[] args) {\n        double r = VALOR_RADIO;\n        double area = Math.PI * r * r;\n        double longi = 2 * Math.PI * r;\n        System.out.printf("Area: %.2f cm2%n", area);\n        System.out.printf("Longitud: %.2f cm%n", longi);\n    }\n}', calcular:function(v){let r=parseFloat(v.radio);return'Area: '+(Math.PI*r*r).toFixed(2)+' cm2\nLongitud: '+(2*Math.PI*r).toFixed(2)+' cm';} },
            '01_3': { inputs: [{label:'DIAGONAL MAYOR', id:'dm', val:'12'},{label:'DIAGONAL MENOR', id:'dmen', val:'8'}], codigo:'public class Rombo {\n    public static void main(String[] args) {\n        double D = VALOR_DM, d = VALOR_DMEN;\n        double area = (D * d) / 2;\n        System.out.println("Area: " + area + " cm2");\n    }\n}', calcular:function(v){let a=(parseFloat(v.dm)*parseFloat(v.dmen))/2;return'Area: '+a+' cm2';} },
            '01_4': { inputs: [{label:'RADIO (cm)', id:'radio', val:'5'},{label:'ALTURA (cm)', id:'altura', val:'10'}], codigo:'public class Cilindro {\n    public static void main(String[] args) {\n        double r = VALOR_RADIO, h = VALOR_ALTURA;\n        double area = 2 * Math.PI * r * (r + h);\n        double vol = Math.PI * r * r * h;\n        System.out.printf("Area: %.2f cm2%n", area);\n        System.out.printf("Volumen: %.2f cm3%n", vol);\n    }\n}', calcular:function(v){let r=parseFloat(v.radio),h=parseFloat(v.altura);return'Area: '+(2*Math.PI*r*(r+h)).toFixed(2)+' cm2\nVolumen: '+(Math.PI*r*r*h).toFixed(2)+' cm3';} },
            '01_5': { inputs: [{label:'LADO (cm)', id:'lado', val:'6'}], codigo:'public class Cubo {\n    public static void main(String[] args) {\n        double l = VALOR_LADO;\n        double area = 6 * l * l;\n        double vol = l * l * l;\n        System.out.println("Area: " + area + " cm2");\n        System.out.println("Volumen: " + vol + " cm3");\n    }\n}', calcular:function(v){let l=parseFloat(v.lado);return'Area: '+(6*l*l)+' cm2\nVolumen: '+(l*l*l)+' cm3';} },
            '01_6': { inputs: [{label:'DIVIDENDO', id:'a', val:'25'},{label:'DIVISOR', id:'b', val:'4'}], codigo:'public class DivisionEntera {\n    public static void main(String[] args) {\n        int a = VALOR_A, b = VALOR_B;\n        System.out.println("Cociente: " + (a/b));\n        System.out.println("Residuo: " + (a%b));\n    }\n}', calcular:function(v){let a=parseInt(v.a),b=parseInt(v.b);return'Cociente: '+Math.floor(a/b)+'\nResiduo: '+(a%b);} },
            '01_7': { inputs: [{label:'NÚMERO (5 dígitos)', id:'num', val:'12345'}], codigo:'public class NumeroInvertido {\n    public static void main(String[] args) {\n        int n = VALOR_NUM, inv = 0;\n        while (n > 0) { inv = inv * 10 + n % 10; n /= 10; }\n        System.out.println("Invertido: " + inv);\n    }\n}', calcular:function(v){let n=v.num,inv='';for(let i=n.length-1;i>=0;i--)inv+=n[i];return'Original: '+n+'\nInvertido: '+inv;} },
            '01_8': { inputs: [{label:'SEGUNDOS', id:'seg', val:'3665'}], codigo:'public class ConversionTiempo {\n    public static void main(String[] args) {\n        int t = VALOR_SEG;\n        int h = t/3600, m = (t%3600)/60, s = t%60;\n        System.out.println(h+"h "+m+"m "+s+"s");\n    }\n}', calcular:function(v){let t=parseInt(v.seg),h=Math.floor(t/3600),m=Math.floor((t%3600)/60),s=t%60;return h+'h '+m+'m '+s+'s';} },
            '01_9': { inputs: [{label:'DINERO TOTAL (S/)', id:'dinero', val:'1000'}], codigo:'public class RepartoDinero {\n    public static void main(String[] args) {\n        double t = VALOR_DINERO;\n        double[] p = {0.30,0.25,0.20,0.15,0.10};\n        for(int i=0;i<5;i++)\n            System.out.printf("Hijo %d: S/.%.2f%n",i+1,t*p[i]);\n    }\n}', calcular:function(v){let t=parseFloat(v.dinero),p=[0.30,0.25,0.20,0.15,0.10],r='';p.forEach((x,i)=>r+='Hijo '+(i+1)+': S/.'+(t*x).toFixed(2)+'\n');return r;} },
            '01_10': { inputs: [{label:'STAND (S/)', id:'stand', val:'500'},{label:'PUBLICIDAD (S/)', id:'publi', val:'300'},{label:'PERSONAL (S/)', id:'personal', val:'400'}], codigo:'public class GastosFeria {\n    public static void main(String[] args) {\n        double s=VALOR_STAND, p=VALOR_PUBLI, pe=VALOR_PERSONAL;\n        System.out.printf("Total: S/.%.2f%n",s+p+pe);\n    }\n}', calcular:function(v){let t=parseFloat(v.stand)+parseFloat(v.publi)+parseFloat(v.personal);return'Total: S/.'+t.toFixed(2);} }
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