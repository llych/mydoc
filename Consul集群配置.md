# 用Docker 容器启动Consul集群

### 1、分别启动三个server节点

启动三个服务节点，并且绑定到容器的同一个ip

```
docker@boot2docker:~$ docker run -d --name node1 -h node1 progrium/consul -server -bootstrap-expect 3
 
docker@boot2docker:~$ JOIN_IP="$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' node1)”
 
docker@boot2docker:~$ docker run -d --name node2 -h node2 progrium/consul -server -join $JOIN_IP
 
docker@boot2docker:~$ docker run -d --name node3 -h node3 progrium/consul -server -join $JOIN_IP
```

### 2、启动client节点

```
docker@boot2docker:~$ docker run -d -p 8400:8400 -p 8500:8500 -p 8600:53/udp -h node4 progrium/consul -join $JOIN_IP
```
