### 在Docker环境中交叉编译Gopher

如下源代码保存在$GOPATH，尝试编译$GOPATH下的一个具体应用程序名字叫BillProcess

```
docker run --rm -it -v "$GOPATH":/usr/src/myapp -w /usr/src/myapp/src/goBillProcess -e GOOS=windows -e GOARCH=386 -e GOPATH=/usr/src/myapp -e GO15VENDOREXPERIMENT=1 golang:1.6 bash

```

如果您仅有一个应用程序在$GOPATH下，即有一个main.go在$GOPATH/src可以使用如下命令

```
docker run --rm -it -v "$GOPATH":/usr/src/myapp -w /usr/src/myapp/src -e GOOS=windows -e GOARCH=386 -e GOPATH=/usr/src/myapp -e GO15VENDOREXPERIMENT=1 golang:1.6 bash

```

在启动容器时，默认设定目标操作系统Windows，系统架构386，可以简单理解成编译出来的程序适用于Windows XP 32位机器。
