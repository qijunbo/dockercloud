systemctl stop tomcat
mkdir -p /opt/limscloud/bak
systemctl stop limscloud
cp ./cloud*.jar  /opt/limscloud/cloud.jar 
chmod 550 /opt/limscloud/cloud.jar
ln -sf  /opt/limscloud/cloud.jar  /etc/init.d/limscloud
systemctl daemon-reload
systemctl start limscloud
