systemctl stop tomcat
rm -rf /opt/tomcat/webapps/cloud
rm -f /opt/tomcat/webapps/cloud.war
cp  /home/docker/env/cloud.war /opt/tomcat/webapps/
chown tomcat /home/docker/env/cloud.war
systemctl start  tomcat
