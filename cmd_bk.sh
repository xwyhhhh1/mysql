[[ ! -f /tmp/data_summary ]] && touch /tmp/data_summary.txt
DATA_FILE_CHECK=/tmp/data_summary.txt
DATA_FILE_NAME=data_summary
TOTAL_DATA=/tmp
LOCALHOST_IP_=$(hostname -I | sed "s/ $//g")
CONTROL=$1
Auto () {
    IP_HOST_=$(hostname -I)
    mem=$(free -h |awk 'NR==2{print $4}')
    swap=$(free -h |awk 'NR==3{print $4}')
    Disk_all=$(df -Th | grep -Evi 'use' | grep '^/' | awk '{print $1}' | xargs)
    Disk_mem=$(df -Th | grep -Evi 'use' | grep '^/' | awk '{print $6}' | xargs)
    timeout 1m yum -y install sysstat > /dev/null 2>&1
    [ $? -eq 0 ] && Cpu_free=$(iostat -c | awk 'NR==4{print $6}' | xargs) || echo "iostat cmd not filed"
    if  [ -s $CONTROL ] ;then
       echo "usage: xxxxx.sh ip"
       exit 1;
    else
       echo "{
          IP: ${IP_HOST_}
          free: ${mem}
          swap: ${swap}
          disk_mem: ${Disk_mem}
          disk_name: ${Disk_all}
          Cpu: ${Cpu_free}
       }" >> ${DATA_FILE_CHECK}
    fi
    mv $DATA_FILE_CHECK ${TOTAL_DATA}/${DATA_FILE_NAME}_${LOCALHOST_IP_}.txt
    DATA_FILE_CHECK=${TOTAL_DATA}/${DATA_FILE_NAME}_${LOCALHOST_IP_}.txt
    EXPECT_=$(which expect)
}
Auto
timeout 30s scp -o "StrictHostKeyChecking no" ${DATA_FILE_CHECK} root@${CONTROL}:${TOTAL_DATA} >/dev/null 2>&1
[ $? -eq 0 ] && echo "is yes" || $EXPECT_ << EOF
spawn scp -o "StrictHostKeyChecking no" ${DATA_FILE_CHECK} root@${CONTROL}:${TOTAL_DATA}
expect {
    "*password:" { send "1Qqlmu@168\r" }
}
expect eof
EOF












