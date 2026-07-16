FROM tomcat:9.0-jdk11
COPY dist/NeoPortfolio.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]