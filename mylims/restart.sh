docker container stop mylims
docker container rm mylims
docker container prune -f
docker container run --name mylims -d -P \
	-v /home/docker/mylims/logs:/usr/local/tomcat/logs \
	-v /home/docker/mylims/iframework:/usr/local/iframework sunway/mylims 
docker port mylims

