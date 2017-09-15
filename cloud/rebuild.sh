docker container stop mytomcat
docker container prune -f 
docker image rm sunway/mytomcat:1	
docker image build -t sunway/mytomcat:1  . 
