### 一、生成自己的证书。

  执行下面的脚本，根据向导一步步完成即可。也可一步步手工执行里面的每一步关键命令完成。

```
#!/bin/bash
# Author: i@xuzeshui.com
# Created Time: 2014-10-09 22:36:38
# Last Modified: 2014-10-09 22:43:56
# File Name: ssl_crt_gen.sh
# Description: 
if [ $# -ne 2 ];then
    echo "$0 [domain] [store_path]"
    exit 1
fi
domain=$1
store_path=$2
cd ${store_path}
echo "Step 1 ....."
openssl genrsa -des3 -out ${domain}-server.key 1024

echo "Step 2 ....."
openssl req -new -key ${domain}-server.key -out ${domain}-server.csr

echo "Step 3 ....."
cp ${domain}-server.key ${domain}-server.key.org

echo "Step 4 ....."
openssl rsa -in ${domain}-server.key.org -out ${domain}-server.key

echo "Step 5 ....."
openssl x509 -req -days 36500 -in ${domain}-server.csr -signkey ${domain}-server.key -out ${domain}-server.crt

echo "all done"

```

这里我生成了 svn.xuzeshui.com-server.crt 和 svn.xuzeshui.com-server.key ，一个为证书，一个为私钥。这两个文件后面配置需要。

### 二、配置nginx配置支持ssl

我这里采用虚拟主机的配置方式，如下示例

```
server {
    listen 80; 
    listen 443 ssl;
    server_name svn.xuzeshui.com ;

    access_log  logs/svn.xuzeshui.com.access.log  main;
    error_log  logs/svn.xuzeshui.com.error.log;

    ssl on; 
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;
    ssl_certificate     /home/work/vhosts/vhosts_conf/ssl_crt/svn.xuzeshui.com-server.crt;
    ssl_certificate_key /home/work/vhosts/vhosts_conf/ssl_crt/svn.xuzeshui.com-server.key;

    root /home/work/vhosts/mail.xuzeshui.com;
    location / { 
        proxy_pass https://svn.xuzeshui.com:8080;                                                                                    
    }   
}
```

说明：

1. 80端口是正常的访问端口，443是ssl的端口，一般这是默认的端口。

2. mssl on 表示打开ssl。

3. 除了指定证书和‘密钥外，还可以配置ssl的会话和Cache等参数。因为https要建立ssl，所以相比http本身对CPU的消耗会多一些，所以有一些优化手段。

4. 这里直接将通过80进来的请求代理要真正的8080端口，这样对外只知道是在80端口即可。nginx对svn的http访问支持不好，网上也找不到成功例子，所以通过nginx代理来完成。这里的8080端口其实就是上篇介绍的svn+apache支持http访问。

至此，nginx支持https访问已经成功了，通过浏览器访问即可，不过由于是自己的证书，会有安全提示，继续浏览即可。不过做为代理到apache的ssl请求，则需要配置apache也支持ssl。


### 三、Apache支持ssl配置。

apacjhe的配置中extra/httpd-ssl.conf 是ssl相关的配置，在httpd.conf中打开，并修改该文件即可。不过由于已经在nginx中配置了，并在433端口监听处理了，所以apache可以不用打开该全局配置。经过实际验证，nginx和apache只要有一个在443端口处理ssl连接的建立即可。所以我对apache的配置，只是启用ssl，不用再创建全局的配置了。

在svn的VirtualHost配置中加入以下三行即可。具体的配置规则可以参考extra/httpd-ssl.conf ，里面有详细的说明。

```
SSLEngine on
SSLCertificateFile "/home/work/vhosts/vhosts_conf/ssl_crt/svn.xuzeshui.com-server.crt"
SSLCertificateKeyFile "/home/work/vhosts/vhosts_conf/ssl_crt/svn.xuzeshui.com-server.key"
```

至此重启服务就可以正常访问了。
