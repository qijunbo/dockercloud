#!/bin/sh
sourceroot=/opt/system/lims-cloud
logfile=${sourceroot}/../build`date "+%Y-%m-%d_%H:%M:%S"`.log
/bin/svn checkout  http://mdm.sunwayworld.com/svn/iframework/iframework/trunk/lims-cloud --username qijunbo --password qijunbo
echo >${logfile}

# build central
echo "Start to build central on: "`date`  >> ${logfile}
centralsrc=${sourceroot}/central/central
cd ${centralsrc}
echo timestamp=`date "+%Y_%m_%d %H:%M:%S"` >${centralsrc}/src/main/resources/version.properties
echo version=1.2 >>${centralsrc}/src/main/resources/version.properties
echo os=Linux >>${centralsrc}/src/main/resources/version.properties
chmod 770 gradlew
./gradlew clean build >> ${logfile}


mkdir -p /opt/central
systemctl stop central
cp -f build/libs/central-1.2.jar  /opt/central/central.jar
chmod 750 /opt/central/central.jar
ln -sf  /opt/central/central.jar  /etc/init.d/central
systemctl daemon-reload
systemctl start central
chkconfig central on
echo >> ${logfile}

