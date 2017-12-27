#!/bin/sh
sourceroot=/opt/system/lims-cloud
logfile=${sourceroot}/../build`date "+%Y-%m-%d_%H:%M:%S"`.log
/bin/svn checkout  http://mdm.sunwayworld.com/svn/iframework/iframework/trunk/lims-cloud --username qijunbo --password qijunbo 
echo >${logfile}

# build remoteclient

echo "Start to build remoteclient on : " `date`  >> ${logfile}
remoteclientsrc=${sourceroot}/remoteclient/remoteclient
cd ${remoteclientsrc} 
echo ${remoteclientsrc}
echo timestamp=`date "+%Y_%m_%d %H:%M:%S"` >${remoteclientsrc}/src/main/resources/version.properties
echo version=1.0 >>${remoteclientsrc}/src/main/resources/version.properties
echo os=Linux >>${remoteclientsrc}/src/main/resources/version.properties
chmod 770 gradlew
./gradlew clean build -D >> ${logfile}
mkdir -p /opt/remoteclient
systemctl stop remoteclient
cp -f build/libs/remoteclient-1.0.jar  /opt/remoteclient/remoteclient-1.0.jar
chmod 750 /opt/remoteclient/remoteclient-1.0.jar
ln -sf  /opt/remoteclient/remoteclient-1.0.jar  /etc/init.d/remoteclient
systemctl daemon-reload
systemctl start remoteclient
chkconfig remoteclient on

