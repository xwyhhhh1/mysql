#!/bin/bash
#定义相关变量
MYSQL_DOWNLOAD_PATH=/usr/local/src
MYSQL_URL=https://mirrors.aliyun.com/mysql/MySQL-8.0/mysql-8.0.28-linux-glibc2.12-x86_64.tar
BASE=/usr/local/mysql
DATA=/data/mysql/
CONFIG=/etc
MYSQL_MD5=362874bef681425ce931a68687805b17
MYSQL_INIT_LOGS=/tmp/mysql_init.logs
MYSQL_START_FILE=/etc/init.d/mysqld.sh
MYSQL_GLIBC_VERSION=mysql-8.0.28-linux-glibc2.12-x86_64

#判断基础条件存在
if id -u mysql > /dev/null 2>&1;then
    echo "mysql user exits"
else 
    useradd mysql -s /sbin/nologin -M
fi
#判断数据目录是否存在
if [ ! -d $DATA ] ;then
   echo "mysql数据目录不存在,创建中......."
   mkdir /data/mysql -p
   chown mysql.mysql /data/mysql/
else
   echo "mysql数据目录已经存在"
fi

#下载mysql二进制安装包,源采用的是清华源
echo "download mysql........"
wget $MYSQL_URL --no-check-certificate -O ${MYSQL_DOWNLOAD_PATH}/mysql.tar.gz 
mysql_md5=$(md5sum $MYSQL_DOWNLOAD_PATH/mysql.tar.gz | awk -F " " '{print $1}')
if [[ $MYSQL_MD5 == $mysql_md5 ]] ;then
    tar -xf ${MYSQL_DOWNLOAD_PATH}/mysql.tar.gz -C $MYSQL_DOWNLOAD_PATH/
    tar -xf ${MYSQL_DOWNLOAD_PATH}/${MYSQL_GLIBC_VERSION}.tar.xz -C $MYSQL_DOWNLOAD_PATH/
    ln -s ${MYSQL_DOWNLOAD_PATH}/${MYSQL_GLIBC_VERSION}/ $BASE
    chown mysql.mysql ${MYSQL_DOWNLOAD_PATH}/${MYSQL_GLIBC_VERSION}/* -R
    echo "Already completed"
else
    echo "page md5 incorrect,please try again!!"
    exit 1;
fi


#安装相关依赖,但是在网络互通的情况下
if ping www.baidu.com -C 3 > /dev/null 2>&1 ;then
    echo "download........"
    yum -y install gcc gcc-c++ openssl-devel boost-devel pcre prel ncurses-devel libaio
    [ $? -eq 0 ] && echo "安装依赖成功" || echo "安装依赖失败,请检查情况"
else
    if timeout 10m  yum -y install gcc gcc-c++ openssl-devel boost-devel pcre prel ncurses-devel libaio ;then
        echo "安装依赖成功"
    else
        echo "网络故障,建议排查"
        exit 2
    fi
fi
if [ ! -f ${CONFIG}/my.cnf ] ;then
   echo "my.cnf not file............"
else
   mv ${CONFIG}/my.cnf ${CONFIG}/my.cnf.d/
fi
#创建mysql配置文件
echo "build congf-file........."
cat << EOF > $CONFIG/my.cnf
[client]
socket = /data/mysql/mysql.sock
[mysqld] 
user = mysql   
socket = ${DATA}/mysql.sock
basedir = $BASE
datadir = $DATA
pid-file = ${DATA}/mysql.pid
log-error = ${DATA}/mysqld.log
character_set_server = utf8mb4
default_authentication_plugin = mysql_native_password
## binlog-settings
# server-id=1
log-bin=mysql-bin-log
binlog_format=ROW
max_binlog_size=100M
expire_logs_days=7
gtid_mode = ON
enforce_gtid_consistency = TRUE
EOF
echo "initdata mysql............"
if [ ! -f $MYSQL_INIT_LOGS ] ;then
   touch $MYSQL_INIT_LOGS
   chown mysql.mysql $MYSQL_INIT_LOGS
   $BASE/bin/mysqld --initialize --user=mysql --basedir=$BASE --datadir=$DATA
else
   $BASE/bin/mysqld --initialize --user=mysql --basedir=$BASE --datadir=$DATA
fi
echo "build mysql start file"
cp $BASE/support-files/mysql.server $MYSQL_START_FILE

$MYSQL_START_FILE start && echo "start successfuly" || exit
# get password
password=$(cat $DATA/mysqld.log | grep password | awk '{print $NF}')
# change default password
$BASE/bin/mysql -uroot -p"$password" --connect-expired-password -e "set password='wtd5842@@tdg...';" && echo "default password is wtd5842@@tdg..." || echo "password cheange filed"


