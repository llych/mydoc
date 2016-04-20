
##### 创建数据卷
```
docker run --name nsq_data -itd nsqio/nsq /nsqd \
    --data-path=/data
```



##### Setup 1

```
docker run --name lookupd -itd -p 4160:4160 -p 4161:4161 nsqio/nsq /nsqlookupd
```


##### Setup 2
```
docker run --name nsqd -itd -p 4150:4150 -p 4151:4151 \
    nsqio/nsq /nsqd \
    --broadcast-address=172.20.7.101 \
    --lookupd-tcp-address=172.20.7.101:4160
```

##### Setup 3
```
docker run --name nsqadmin -itd -p 4171:4171 \
    nsqio/nsq /nsqadmin \
    --lookupd-http-address=172.20.7.101:4161
```

##### Setup 4
```
docker run --name nsq_to_file -itd \
    nsqio/nsq /nsq_to_file \
    --topic=test \
    --output-dir=/tmp \
    --lookupd-http-address=172.20.7.101:4161
```

