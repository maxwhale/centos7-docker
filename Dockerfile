#
# MAINTAINER          Max
# DOCKER-VERSION      2.00
# CENTOS-VERSION      7
# Dockerfile-VERSION  2.0
# DATE                10/31/2016
#

FROM centos:7.2
MAINTAINER Max

ENV TZ "Asia/Shanghai"
ENV TERM xterm

ADD aliyun-mirror.repo /etc/yum.repos.d/CentOS-Base.repo
ADD aliyun-epel.repo /etc/yum.repos.d/epel.repo

# Update
RUN yum -y update

RUN yum -y install wget tar screen htop passwd nano openssh-server pwgen && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_ecdsa_key && \
    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM yes/g" /etc/ssh/sshd_config

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV AUTHORIZED_KEYS **None**
ENV ROOT_PASS LNMP123

VOLUME ["/home"]

EXPOSE 80 
EXPOSE 21 
EXPOSE 22 
EXPOSE 3306 
EXPOSE 6379 
EXPOSE 11211

CMD ["/run.sh"]
