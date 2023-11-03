FROM tomcat:8.0.18-jre8
COPY target/maven-web-application.war /usr/locat/tomcat/webapps/maven-web-application.war