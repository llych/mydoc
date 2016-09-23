[Unit]
 22 Description=Docker Application Container Engine
 23 Documentation=http://docs.docker.com
 24 After=network.target docker.socket
 25 Requires=docker.socket
 26 
 27 [Service]
 28 Type=notify
 29 MountFlags=slav
 30 EnvironmentFile=-/etc/default/docker
 31 ExecStart=/usr/bin/docker daemon -H fd:// $DOCKER_OPTS
 32 LimitNOFILE=1048576
 33 LimitNPROC=1048576
 34 LimitCORE=infinity
 35 TimeoutStartSec=0
 36 Delegate=yes
 37 
 38 [Install]
 39 Also=docker.socket
 40 WantedBy=multi-user.target
