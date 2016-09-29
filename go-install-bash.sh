#!/bin/bash
 
#
# Bash script for fast setting up Golang environment
#
# Usage:
#
# sudo chmod +x gostartup && ./gostartup
#
 
red="\e[31m"
green="\e[32m"
nocolor="\e[0m"

# .bashrc文件所在目录，环境变量在这个文件里面配置
bashrc="/home/"$USER"/.bashrc"
# 你想把golang项目放在哪里？默认为/home/$USER/go
echo -e "Where do you want to store golang projects [default: /home/$USER/go] \c:"
read gopath
 
if [[ $gopath == "" ]]
then
  gopath="/home/$USER/go/"
fi
 
# 如果需要，给gopath加上尾部斜杠
if [[ "${gopath: -1}" != '/' ]];
then
  gopath=$gopath"/"
fi
 
# golang编译器安装路径
gobin=$gopath"go"
# 项目根路径
projects=$gopath"go-projects"
# 你的github项目路径
struct=$gopath"go-projects/src/github.com"$github_user
 
echo -e "What's you Github username: \c'"
read github_user

# 如果不提供github用户名直接退出
if [[ $github_user == "" ]]
then
  echo -e $red"[Error]: Github username can't be empty"$nocolor
  exit 0
fi

# 你要安装最新的golang编译器么？
echo -e "Do you want to get last golang compiler [y/n]: \c"
read getgo
 
# 如果gopath目录不存在，创建之
if [ ! -d "$gopath" ]; then
  mkdir $gopath
fi
 
# 如果golang编译器所在目录不存在，创建之
if [ ! -d "$gobin" ]; then
  mkdir $gopath"go"
fi
 
# 如果项目所在路径不存在，创建之
if [ ! -d "$projects" ]; then
  mkdir $gopath"go-projects"
fi
 
# 如果你的github项目所在目录不存在，创建之
if [ ! -d "$struct" ]; then
  mkdir -p $gopath"go-projects/src/github.com/"$github_user
fi
 
# 如果你要安装golang，则下载安装到$gopath/go目录，需要hg命令
if [[ "$getgo" == "y" ]];
then
  hg clone -u release "https://code.google.com/p/go" $gopath"go"
  exec $gopath"go/src/all.bash"
fi

# 将GOPATH写入配置文件，将golang编译器的bin目录放入PATH路径，然后写入配置文件。
echo "export GOPATH="$gopath"go-projects" >> $bashrc
echo "export PATH=$PATH:$GOPATH/"$gopath"go/bin" >> $bashrc
 
echo -e $green"done" $nocolor
 
exit 0
