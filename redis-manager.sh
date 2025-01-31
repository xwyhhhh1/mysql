# /bin/bash

# export vars
redis_dir=/usr/local/redis
redis_bin=${redis_dir}/bin
# redis_config=${redis_dir}/bin/redis.conf
redis_pid_dir=/var/run/

## funntion
start () {
    for i in $@
    do
        ${redis_bin}/redis-server $i &
    done
}
stop () {
    ${redis_bin}/redis-cli shutdown    # 获取可以键入变量实现不进入终端即可执行命令功能，待开发

}

check_redis_status(){
    for i in $@
    do
        if [[ $i =~ ^[0-9]+$ ]] ;then
            check_port $i
            check_pid_file $i
        else
            usage
        fi
    done

}
check_port(){
    if which netstat > /dev/null 2>&1 ;then
        netstat -tnulp | grep $1 > /dev/null 2>&1 && echo "port $1 exist" || echo "port $1 does not exists"
    else
        ss -tnulp | grep $1  > /dev/null 2>&1 && echo "port $1 exist" || echo "port $1 does not exists"

    fi
}

check_pid_file(){
    [ -f $redis_pid_dir/redis_${1}.pid ] && echo "pid file exist" || echo "pid file does not exists"
}

usage(){
    echo "zzzzz"
    exit 1
}

case $1 in
    check)
        shift
        check_redis_status $@
        ;;
    start)
        shift
        start $@
        ;;
    stop)
        shift
        stop $@
        ;;
    *)
        usage
        ;;

esac
