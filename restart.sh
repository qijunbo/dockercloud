docker container stop lims
docker container rm lims
docker container prune -f
docker container run --name lims -d -p 8080:8080 sunway/lims:1 
 