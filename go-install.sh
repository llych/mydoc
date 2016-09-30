#!/bin/bash
# -*- coding: UTF-8 -*-
# 获取当前脚本执行路径
OPT_PATH="/opt/golang"
WEBAPP_PATH="/opt/kongfu"
bashrc="/etc/profile"
SELFPATH=$(cd "$(dirname "$0")"; pwd)

install_yilai(){
    yum -y install zlib-devel openssl-devel perl hg cpio expat-devel gettext-devel curl curl-devel perl-ExtUtils-MakeMaker hg wget gcc gcc-c++ unzip tar vim*
}
# 安装git
install_git(){
    unstall_git
 if [ ! -f $SELFPATH/git-2.10.0.tar.gz ];then
    wget -c https://www.kernel.org/pub/software/scm/git/git-2.10.0.tar.gz
 fi
    tar zxvf git-2.10.0.tar.gz
    cd git-2.10.0
    ./configure --prefix=$OPT_PATH/git
    make
    make install
    ln -s $OPT_PATH/git/bin/* /usr/bin/
    rm -rf $SELFPATH/git-2.10.0
}
# 卸载git
unstall_git(){
    rm -rf $OPT_PATH/git
    rm -rf $OPT_PATH/git/bin/git
    rm -rf $OPT_PATH/git/bin/git-cvsserver
    rm -rf $OPT_PATH/git/bin/gitk
    rm -rf $OPT_PATH/git/bin/git-receive-pack
    rm -rf $OPT_PATH/git/bin/git-shell
    rm -rf $OPT_PATH/git/bin/git-upload-archive
    rm -rf $OPT_PATH/git/bin/git-upload-pack
}

# 安装go
install_go(){
    cd $SELFPATH
    uninstall_go
 # 动态链接库，用于下面的判断条件生效
    ldconfig
 # 判断操作系统位数下载不同的安装包
    if [ $(getconf WORD_BIT) = '32' ] && [ $(getconf LONG_BIT) = '64' ];then
    # 判断文件是否已经存在
        if [ ! -f $SELFPATH/go1.7.linux-amd64.tar.gz ];then
            wget -c http://www.golangtc.com/static/go/1.7/go1.7.linux-amd64.tar.gz
        fi
        tar zxvf go1.7.linux-amd64.tar.gz
        
    else
        if [ ! -f $SELFPATH/go1.7.linux-386.tar.gz ];then
            wget -c http://www.golangtc.com/static/go/1.7/go1.7.linux-386.tar.gz
        fi
        tar zxvf go1.7.linux-386.tar.gz
    fi

    mv go $OPT_PATH/
    ln -s $OPT_PATH/go/bin/* /usr/bin/

    export GOROOT=$OPT_PATH/go
    export GOBIN=$OPT_PATH/go/bin
    export GOPATH=$WEBAPP_PATH/webapp

    # echo "export GOROOT=$OPT_PATH/go" >> $bashrc
    # echo "export GOBIN=$OPT_PATH/go/bin" >> $bashrc
    # echo "export GOPATH=$OPT_PATH/mygo" >> $bashrc
    # echo 'export PATH=$PATH:$GOPATH/bin;$GOROOT/bin' >> $bashrc



}
# 卸载go
uninstall_go(){
    rm -rf $OPT_PATH/go
    rm -rf /usr/bin/go
    rm -rf /usr/bin/godoc
    rm -rf /usr/bin/gofmt
}
# 安装webapp
install_webapp(){
    uninstall_webapp
    cd $WEBAPP_PATH
    if [ ! -d $WEBAPP_PATH/webapp ];then
        git clone -b vendor http://git.husor.com/sysdev/webapp.git
        cd $WEBAPP_PATH/webapp
        go get -v
    fi
    #go get github.com/constabulary/gb/...
    mkdir -p webapp/release

}
# 卸载webapp
uninstall_webapp(){
    rm -rf $OPT_PATH/webapp
}
# 编译客户端
client(){
    cd $WEBAPP_PATH/webapp
    go build
    
    cp -R webapp template static conf logs release
}

echo "Please select number"
echo "------------------------"
echo "1、One key installation"
echo "2、Installation package"
echo "3、install git"
echo "4、install golang env"
echo "5、remove golang env"
echo "6、get kongfu-admin"
echo "7、build kongfu-admin"
echo "8、remove kongfu-admin"
echo "9、run kongfu-admin"
echo "------------------------"
read num
case "$num" in
    [1] )
    install_yilai
    install_git
    install_go
    install_webapp
    ;;
    [2] )
    install_yilai
    ;;
    [3] )
    install_git
    ;;
    [4] )
    install_go
    ;;
    [5] )
    uninstall_go
    ;;
    [6] )
    install_webapp
    ;;
    [7] )
    client
    ;;
    [8] )
    unstall_git
    uninstall_go
    uninstall_webapp
    ;;
    [9] )
    cd $WEBAPP_PATH/webapp/
    sudo nohup ./webapp & >> logs/log.log
    ;;
    *) echo "";;
esac
