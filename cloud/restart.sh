/bin/systemctl stop  nginx.service
docker container stop mytomcat
docker container rm mytomcat
docker container prune -f
rm -f  /home/docker/cloud/logs/*
rm -rf /home/docker/cloud/webapps/*
docker container run --name mytomcat -d \
  -v /home/docker/cloud/logs:/usr/local/tomcat/logs \
  -v /home/docker/cloud/webapps:/usr/local/tomcat/webapps -p 8086:8080 sunway/mytomcat:1 

/bin/systemctl start nginx.service
