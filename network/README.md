

Commonly Used Commends
--
[Reference](https://docs.docker.com/engine/userguide/networking/#the-default-bridge-network)
 


docker network ls

- show ip address
```
ip a
ip addr show
ifconfig
```

docker network inspect bridge

docker run -itd --name=container1 busybox

docker run -itd --name=container2 busybox

docker run --link option, but this is not recommended in most cases.

docker attach container1
Detach from container3 and leave it running using CTRL-p CTRL-q.

docker network create --driver bridge isolated_nw

docker run --network=isolated_nw -itd --name=container3 busybox

- [Network Commands](https://docs.docker.com/engine/userguide/networking/work-with-networks/)

```
docker network create
docker network connect
docker network ls
docker network rm
docker network disconnect
docker network inspect
```
