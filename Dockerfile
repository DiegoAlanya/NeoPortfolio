FROM tomcat:9.0

# Instalar conector MySQL
ADD https://repo1.maven.org/maven2/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar /usr/local/tomcat/lib/

# Copiar proyecto
COPY dist/NeoPortfolio.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]