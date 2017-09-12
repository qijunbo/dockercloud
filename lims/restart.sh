docker container stop lims
docker container rm lims
docker container prune -f
docker container run --name lims -d \
    -v /home/docker/mysql/user1/logs:/usr/local/tomcat/logs \	
	-p 8080:8080 sunway/lims:1 
 
