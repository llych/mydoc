## 1.安装kvm

打开cmd,执行如下的脚本：

    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/aspnet/Home/master/kvminstall.ps1'))"

安装完以后，通过 kvm install latest –p 安装最新版本的KRE。


## 2.创建第一个应用程序(Startup.cs and project.json)

在asp.net 5中，最重要的两个文件，就是Startup.cs和project.json。

project.json文件说明：https://github.com/aspnet/Home/wiki/Project.json-file

Startup.cs如其名字所示是asp.net5应用程序启动时寻找的文件。

下面是创建我们的project.json和Startup.cs文件。

a.创建一个project.json的空文件：
在当前路径下执行下面的命令：

image

上面的命令是安装运行asp.net应用程序最基本的包。如下图所示：

image

安装完成后，可以看到project.json文件自动更新了：

image

 

接下来需要做的是在project.json文件中添加command节点：
"commands": {
    "web": "Microsoft.AspNet.Hosting --server Microsoft.AspNet.Server.WebListener --server.urls http://localhost:5000"
    }
project.json文件如下：

image
现在我们就完成了project.json文件的创建。下面创建Startup.cs文件。
image
只有简单的输出Hello World的代码。
 
## 3.使用k web来运行应用程序。

 web这个命令是我们在project.json文件中定义好的。它会让Microsoft.AspNet.Server.WebListener监听5000这个端口
