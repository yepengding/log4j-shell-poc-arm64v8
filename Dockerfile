FROM --platform=linux/arm64/v8 arm64v8/tomcat:8.0-jre8

RUN rm -rf /usr/local/tomcat/webapps/*
ADD target/log4shell-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080 
CMD ["catalina.sh", "run"]
