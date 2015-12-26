##Ubuntu中Nginx的安装与配置

$sudo apt-get install spawn-fcgi

$sudo apt-get install nginx

      ubuntu安装Nginx之后的文件结构大致为：

      所有的配置文件都在/etc/nginx下，并且每个虚拟主机已经安排在了/etc/nginx/sites-available下

      启动程序文件在/usr/sbin/nginx

      日志放在了/var/log/nginx中，分别是access.log和error.log

      并已经在/etc/init.d/下创建了启动脚本nginx

      默认的虚拟主机的目录设置在了/usr/share/nginx/www


##启动Nginx

   （1）在线安装的启动过程

      $sudo /etc/init.d/nginx start

   （2）重新启动nginx:

      $/etc/init.d/nginx restart

   （3）启动FastCGI:

      $spawn-fcgi -a 127.0.0.1 -p 9000 -C 10 -u www-data -f /usr/bin/php-cgi

      spawn-fcgi启动出现错误时，查看php-cgi是否安装，如果么有的话，安装php5-cgi。

      $sudo apt-get install php5-cgi


##Nginx配置

    Nginx的配置文件是/etc/nginx/nginx.conf，其中设置了一些必要的参数，我们发现其中这样的语句：

    include /etc/nginx/sites-enabled/*

    可以看出/etc/nginx/sites-enabled/default文件也是一个核心的配置文件，其中包含了主要的配置信息，

    如服务器跟目录、服务器名称、location信息和server信息。

    对于源代码安装的nginx，配置文件为/usr/local/nginx/conf/nginx.conf。

    下面主要说明location的匹配规则：

   （1）= 前缀的指令严格匹配这个查询。如果找到，停止搜索。

   （2）剩下的常规字符串，最长的匹配优先使用。如果这个匹配使用 ^~ 前缀，搜索停止。

   （3）正则表达式，按配置文件里的顺序，第一个匹配的被使用。

   （4）如果第三步产生匹配，则使用这个结果。否则使用第二步的匹配结果。

    在location中可以使用常规字符串和正则表达式。

    如果使用正则表达式，你必须使用以下规则：

       （1）~* 前缀选择不区分大小写的匹配

       （2）~  选择区分大小写的匹配

    例子：

     location = / {

　　　　# 只匹配 / 查询。

　　　　[ configuration A ]
     }

　　location / {

　　　　# 匹配任何查询，因为所有请求都以 / 开头。

            # 但是正则表达式规则和长的块规则将被优先和查询匹配。

　　　　[ configuration B ]

　　}

　　location ^~ /images/ {

　　　　# 匹配任何以 /images/ 开头的任何查询并且停止搜索。

           # 任何正则表达式将不会被测试。

　　　　[ configuration C ]

　　}

　　location ~* \.(gif|jpg|jpeg)$ {

           # 匹配任何以 gif、jpg 或 jpeg 结尾的请求。

          # 然而所有 /images/ 目录的请求将使用 Configuration C。

 　　　[ configuration D ]

　　}

　　这里你还要对正则表达式有一定的了解！！！
