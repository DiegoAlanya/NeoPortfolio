FROM tomcat:9.0-jdk11

# Descargar conector MySQL
RUN apt-get update && apt-get install -y wget
RUN wget -O /usr/local/tomcat/lib/mysql-connector.jar https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar

# Copiar el proyecto
COPY dist/NeoPortfolio.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]