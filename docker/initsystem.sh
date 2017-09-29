#prepare for everyone 
mkdir -p  /opt/docker/everyone/mysql/initsql
mkdir -p  /opt/docker/everyone/mysql/conf/

cp *.sql /opt/docker/everyone/mysql/initsql/init.sql
cp docker.cnf  /opt/docker/everyone/mysql/conf/docker.cnf

tree /opt/docker/everyone/
