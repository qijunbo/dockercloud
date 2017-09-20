
docker container prune -f  
docker run --name mysql -e MYSQL_ROOT_PASSWORD=sunway123# -d -p 3306:3306 \
    -v /home/docker/mysql/user1/data:/var/lib/mysql  \
    -v /home/docker/mysql/user1/initsql:/docker-entrypoint-initdb.d \
      mysql --character-set-server=utf8 --collation-server=utf8_general_ci

