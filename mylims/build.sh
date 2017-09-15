docker container stop mylims
docker container prune -f 
docker image rm sunway/mylims
docker image build -t sunway/mylims  .
