#prepare for everyone 
mkdir -p  /docker/everyone/initsql
mkdir -p  /docker/everyone/conf

cp -f init.sql /docker/everyone/initsql/
cp -f docker.cnf /docker/everyone/conf/

tree /docker/everyone/
