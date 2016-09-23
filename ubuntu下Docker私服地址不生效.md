
### /usr/lib/systemd/system/docker.service

```

[Unit]
Description=Docker Application Container Engine
Documentation=http://docs.docker.com
After=network.target docker.socket
Requires=docker.socket

[Service]
Type=notify
MountFlags=slav
EnvironmentFile=-/etc/default/docker
ExecStart=/usr/bin/docker daemon -H fd:// $DOCKER_OPTS
LimitNOFILE=1048576
LimitNPROC=1048576
LimitCORE=infinity
TimeoutStartSec=0
Delegate=yes

[Install]
Also=docker.socket
WantedBy=multi-user.target


```
