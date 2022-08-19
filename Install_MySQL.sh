#!/bin/bash
#定义相关变量
MYSQL_DOWNLOAD_PATH=/usr/local/src
MYSQL_URL=https://mirrors.tuna.tsinghua.edu.cn/mysql/downloads/MySQL-5.7/mysql-5.7.38-linux-glibc2.12-x86_64.tar.gz
MYSQL_INSTALL=/data/3306/
BASE=${MYSQL_INSTALL}mysql
DATA=/data/3306/data
CONFIG=/etc
#判断基础条件存在
if id -u mysql ;then
    echo "mysql user exits"
else 
    useradd mysql -s /sbin/nologin -M
fi
if [ -d /data/3306/data ] ;then
    echo "download mysql........"
    #下载mysql二进制安装包，源采用的是清华源
    wget $MYSQL_URL --no-check-certificate -O ${MYSQL_DOWNLOAD_PATH}/mysql && tar -xf ${MYSQL_DOWNLOAD_PATH}/mysql.tar.gz -C $MYSQL_INSTALL
else
    mkdir -p /data/3306/data
    echo "download mysql........"
    wget $MYSQL_URL --no-check-certificate -O ${MYSQL_DOWNLOAD_PATH}/mysql && tar -xf ${MYSQL_DOWNLOAD_PATH}/mysql.tar.gz -C $MYSQL_INSTALL

fi
chown mysql.mysql ${MYSQL_INSTALL}mysql/* -R
chown mysql.mysql /data/* -R
#安装相关依赖，但是在网络互通的情况下
if ping www.baidu.com -C 3 > /dev/null 2>&1 ;then
    echo "download........"
    yum -y install gcc gcc-c++ openssl-devel boost-devel pcre prel ncurses-devel libaio
    [ $? -eq 0 ] && echo "安装依赖成功" || echo "安装依赖失败,请检查情况"
else
    if timeout 3m  yum -y install gcc gcc-c++ openssl-devel boost-devel pcre prel ncurses-devel libaio ;then
        echo "安装依赖成功"
    else
        echo "网络故障,建议排查"
    fi
fi
mv ${CONFIG}/my.cnf /${CONFIG}/my.cnf.d/
#创建mysql配置文件
cat << EOF > /etc/my.cnf
[mysqld]
port = 3306
user = mysql
socket = ${BASE}/mysql.pid
base = $BASE
data = $DATA
pid-file = ${BASE}/mysql.pid
log-error = ${BASE}/mysqld.log
EOF
$BASE/bin/mysqld --initifi --user=mysql --base=$BASE --data=/data