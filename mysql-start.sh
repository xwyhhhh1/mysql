#!/bin/bash
data_dir=/data/mysql/
base_dir=/usr/local/mysql/
conf_dir=/etc
mysql_bin=/usr/local/mysql/bin
read -t 100 -p "mysql password: " passwd

start () {
    if [ $(ps -axu | grep -E "mysqld_safe|mysqld" | grep -v "grep" | wc -l) -eq 0 ] ;then
        if [ $(ls -l /data/mysql/ | grep -E "*.sock" | wc -l) -eq 0 ] ;then
            if [ $(ss -tnulp | grep mysqld | wc -l) -eq 0 ] ;then
               echo "process,socket,port not find start mysqld......"
               nohup ${mysql_bin}/mysqld_safe --defaults-file=${conf_dir}/my.cnf --datadir=$data_dir --basedir=$base_dir &
               [ $? -eq 0 ] && echo "start SUCCESS!!!" || echo "Error please check nohub.out and mysqld.log"
               sleep 10
            else
                echo "port exits!!"
                exit 1;
            fi

        else
            echo "sock exits!!!!"
            exit 1;
        fi

    else
        echo "process exits!!!!"
        exit 1;
    fi
}

stop () {
     if [ $(ps -axu | grep -E "mysqld_safe|mysqld" | grep -v "grep" | wc -l) -ge 2 ] ;then
        if [ $(ls -l /data/mysql/ | grep -E "*.sock" | wc -l) -eq 2 ] ;then
            if [ $(ss -tnulp | grep mysqld | wc -l) -ge 1 ] ;then
                echo "stop mysql........"
                nohup ${mysql_bin}/mysqladmin -uroot -p$passwd -S ${data_dir}mysql.sock shutdown
                [ $? -eq 0 ] && echo "stop SUCCESS!!!" || echo "Error please check nohub.out and mysqld.log"
                sleep 10
            else
                echo "port in not find"
            fi

        else
            echo "sock in noit find"
        fi

    else
        echo "process in not find"
    fi
}
rester () {
    echo "restart........."
    stop
    start

}
usage () {
    echo "xxxx.sh [start|stop|restart]"
}
case $1 in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        rester
        ;;
    *)
        usage
esac
