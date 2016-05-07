# golang 开发环境
# 使用Docker [代码构建] 和 [持续集成]
# Version:1.0.0

FROM tutum/ubuntu:latest
MAINTAINER Eason <80186658@qq.com>


# 设置时区
RUN echo 'Asia/Shanghai' > /etc/timezone
# 同步本机源
#RUN rm /etc/apt/sources.list
#ADD sources.list /etc/apt/

# 附加必须的依赖
RUN apt-get update && apt-get install -yq git wget gcc
RUN rm -rf /var/cache/apt/archives /var/cache/apt/archives/partial

RUN wget -q http://www.golangtc.com/static/go/1.6.2/go1.6.2.linux-amd64.tar.gz

RUN tar -xf go1.6.2.linux-amd64.tar.gz -C /usr/local && \
rm go1.6.2.linux-amd64.tar.gz

RUN echo 'export GOPATH=/gopath' >> /etc/profile && \
echo 'export PATH=$PATH:$GOPATH/bin:$GOROOT/bin' >> /etc/profile && \
echo 'export GOROOT=/usr/local/go' >> /etc/profile

RUN echo 'export GOPATH=/gopath' >> /root/.bash_profile && \
echo 'export PATH=$PATH:$GOPATH/bin:$GOROOT/bin' >> /root/.bash_profile && \
echo 'export GOROOT=/usr/local/go' >> /root/.bash_profile

# 设置SSH服务中终端的超时时间或不超时
RUN echo 'ClientAliveInterval 120' >> /etc/ssh/sshd_config && \
echo 'ClientAliveCountMax 3' >> /etc/ssh/sshd_config


VOLUME /code
ENV GOVERSION 1.5.1
ENV GOROOT /usr/local/go
ENV GOPATH /gopath
ENV PATH $PATH:$GOPATH/bin:$GOROOT/bin
ENV ROOT_PASS secondlife

RUN go get github.com/tools/godep
RUN mkdir /gopath/src
WORKDIR /gopath/src

# RUN ln -s /code/goapi

EXPOSE 22 80 8080
