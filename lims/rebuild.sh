docker container stop lims
docker container prune -f 
docker image rm sunway/lims:1	
docker image build -t sunway/lims:1  . 
