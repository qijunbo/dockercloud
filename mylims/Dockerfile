# Setup a tomcat 8 as a development environment.
FROM tomcat:latest
VOLUME  /usr/local/iframework  /usr/local/tomcat/logs 
#COPY  server-oracle.xml /usr/local/tomcat/conf/server.xml
#COPY  server-10.xml /usr/local/tomcat/conf/server.xml
COPY  server-mysql.xml /usr/local/tomcat/conf/server.xml
