FROM tomcat:9.0-jdk11

# Instalar conector MySQL
ADD https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar /usr/local/tomcat/lib/mysql-connector-java-8.0.33.jar

# Copiar el proyecto
COPY dist/NeoPortfolio.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]