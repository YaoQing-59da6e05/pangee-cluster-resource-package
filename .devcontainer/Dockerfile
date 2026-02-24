FROM quay.io/skopeo/stable:latest
#ARG http_proxy http://10.10.12.225:8118
#ARG https_proxy http://10.10.12.225:8118
#ARG no_proxy 10.10.12.225,127.0.0.1,::1,localhost

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && yum update -y && yum install -y ssh sshpass openssl glibc-langpack-zh python3 ansible && yum clean all

ENV LANG=zh_CN.utf8