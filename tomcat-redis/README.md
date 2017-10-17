TOMCAT WITH REDIS
==

按照Docker官方给的容器设计[Best Practice](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/), 肯定是不推荐这么做的. 这是一个临时措施.
tomcat容器里面, 加入redis作为cache使用.

使用版本: [tomcat 8.5](https://github.com/docker-library/tomcat/tree/master/8.5/jre8-alpine), 
[redis 4.0.2](https://github.com/docker-library/redis/blob/master/4.0/alpine/Dockerfile)

Usage
--
- Create Docker image

```
./rebuild.sh
```

- Run

```
docker container prune -f && docker  run --name redtom -d -P tomcat-redis
```

