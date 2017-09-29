systemctl stop nginx
docker container prune -f
systemctl start nginx
docker ps -a
