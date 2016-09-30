
#### 官网下载node.js linux  binaries文件。直接把文件解压复制到某个目录下

* sudo cp -r node-v0.10.28  /opt/node

* sudo vi /etc/profile.d/node.sh

* node.sh文件内容：
    
    export NODE_HOME=/opt/node
    export PATH=$PATH:$NODE_HOME/bin
    export NODE_PATH=$PATH:$NODE_HOME/lib/node_modules
    
* 软连接
 
    sudo ln -s /opt/node/bin/node /usr/bin/node
    sudo ln -s /opt/node/bin/npm /usr/bin/npm
