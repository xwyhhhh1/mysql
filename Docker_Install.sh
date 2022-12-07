#!/bin/bash
#version:1.0
#email:2293558627@qq.com
read -t 100 -p "镜像加速器地址: " URL
Profile () {
    echo "<=================>Environmental preparation........<=================>"
    yum -y install wget gcc gcc-c++ >> /dev/null 2>&1
    wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
    wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
    yum -y install yum-utils device-mapper-persistent-data lvm2 >> /dev/null 2>&1
    yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo >> /dev/null
    yum clean all >> /dev/null
    yum makecache >> /dev/null
}
Install () {
    yum -y install docker-ce docker-ce-cli containerd.io >> /dev/null 2>&1
    [ $? -eq 0 ] && echo "<=================>install Dependent is yes<====================>" || echo "<=================>Install Error<====================>" ; exit 1
    systemctl restart docker
    systemctl enable docker >> /dev/null 2>&1
}
Check () {
    echo "Client version: $(docker version | awk 'NR==2{print $2}')"
    echo "Server version: $( docker version | awk 'NR==13{print $2}')"
}
Replace_accelerator () {
    if [ ! -d /etc/docker ] ; then
        echo "<==============>Create directory and Modify File........<================>"
        mkdir -p /etc/docker
        echo "{" >> /etc/docker/daemon.json
        echo " \"registry-mirrors\": [\"$URL\"]" >> /etc/docker/daemon.json
        echo "}"
        docker pull centos >> /dev/null 2>&1
    else
        echo "<==============>modfiy File......<==============>"
        echo "{" >> /etc/docker/daemon.json
        echo " \"registry-mirrors\": [\"$URL\"]" >> /etc/docker/daemon.json
        echo "}"
        docker pull centos >> /dev/null 2>&1
    fi
}
Check_Network () {
    echo "$(cat /proc/sys/net/ipv4/ip_forward)"
    echo "非一请开启网络转发功能"
}
Start_Docker () {
    sysctl -p
    echo "running: $(docker ps -a | awk 'NR==2{print $1}')"
}
cat << EOF
如果以上没有报错则已成功安装docker
docker run -it centos:latest /bin/bash 
请执行以上命令进入容器
EOF
Profile
Install
Check
Replace_accelerator
Check_Network