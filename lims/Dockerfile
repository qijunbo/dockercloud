#Create a LIMS image based on tomcat8
FROM tomcat:latest
LABEL name="lims-all"
COPY  product /sunway/product/ 
COPY  server.xml /usr/local/tomcat/conf/
VOLUME /usr/local/tomcat/logs /usr/local/tomcat/conf/

