#!/bin/sh
name=$1

if [ -z "${name}" ]; then
   echo "Usage: $0 name"
   exit -1 ;
fi

docker exec -it mysql${name} mysqladmin -uroot -psunway123# variables  | grep  "case" 
echo "-------------------------------"
echo "Customized mysql configure: "
docker exec -it mysql${name} cat /etc/my.cnf 
echo
echo "-------------------------------"
echo "check the existance of init.sql :" 
docker exec -it mysql${name} ls -l /docker-entrypoint-initdb.d
echo 
docker exec -it mysql${name} mysql -uroot -psunway123# -e "show databases;"

docker exec -it mysql${name} mysql -uroot -psunway123# -e "SELECT host FROM mysql.user WHERE User = 'root';"


