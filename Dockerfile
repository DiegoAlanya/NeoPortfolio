FROM tomcat:9.0-jdk11

# Descargar conector MySQL
RUN curl -o /usr/local/tomcat/lib/mysql-connector.jar https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar

COPY dist/NeoPortfolio.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]