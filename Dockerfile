FROM tomcat:9.0

# Descargar conector MySQL directamente
RUN curl -o /usr/local/tomcat/lib/mysql-connector-java-8.0.33.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar

# Copiar proyecto
COPY dist/NeoPortfolio.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]