#!/bin/sh
sourceroot=/opt/system/lims-cloud
logfile=${sourceroot}/../checkout-`date "+%Y-%m-%d"`.log
/bin/svn checkout  http://mdm.sunwayworld.com/svn/iframework/iframework/trunk/lims-cloud --username qijunbo --password qijunbo >> ${logfile}

