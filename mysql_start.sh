#!/bin/bash
#version:1.0
#auth:xxx
#email:xxxxxxxx
#usage:start mysql
read -t 10 -p "opt: " OPT
SOCKET=/tmp/mysql/mysql.sockt
MYSQL_FILE=/usr/local/mysql
MYSQL_CONFIG=/etc/my.cnf
usage () {
    echo "usage: "
    echo "please opt start,stop,restart"
}


start () {
    cd /usr/local/mysql/bin
    if [ -f $SOCKET ] ;then
        echo "mysql is running"
    else
        echo "mysql starting......."
        cd ${MYSQL_FILE}/bin
        ./mysql_safe --default-file $MYSQL_CONFIG &
    fi
}

stop () {
    if [ -f $SOCKET ] ;then
        echo "mysql is stopping......"
        kill -9 $(ps -aux | grep -v grep | grep mysql_safe | awk '{print $2}')
        sleep 10
    else
        echo "mysql stopped"
    fi
}


restart () {
    stop
    sleep 10
    start
}


case $OPT in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    *)
        usage
esac
