mkdir -p /opt/central
systemctl stop central
#cp -f  /home/docker/env/cloud*.jar  /opt/central/cloud.jar 
cp -f central-1.2.jar  /opt/central/central.jar
chmod 750 /opt/central/central.jar
ln -sf  /opt/central/central.jar  /etc/init.d/central
systemctl daemon-reload
systemctl start central
chkconfig central on
