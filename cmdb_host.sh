#/bin/bash

Tmp_File=/tmp/data.txt
Cmdb_File=/tmp/cmdb.xlsx
IP_File=ip.txt
Port=22
User=secure

Get_Data () {
    for i in $(cat $IP_File | while read line ;do echo $line ;done)
    do  
        if  Conntion_test $i ;then
            Execute $i  > $Tmp_File #在使用ssh远程执行命令的时候，awk因为带$的原因取不出值，或取值有问题，必须要\转义一下才行
            sleep 0.5
            cat $Tmp_File | xargs -n 2 | tr ' ' '\t' >> $Cmdb_File # 有问题,需要优化
        else
            echo "$i ping is error"
        fi
    done
}
Execute () {
    local ip=$1
    ssh $User@$ip -q -p $Port -o StrictHostKeyChecking=no "sudo hostname ; sudo hostname | awk -F "-" '{print\$NF}'  | sed 's/[a-z]/./g' "
}
Clean_file () {
    [ $(cat ${Tmp_File} | wc -l) -gt 2 ] && exit 2 || echo "del tmp file....."
    rm -f $Tmp_File
}
Conntion_test () {
    local Test=$i
    ping -c 3 $Test  > /dev/null 2>&1
    [ $? -eq 0 ] && true || false
}

main () {
    Get_Data
    Clean_file
}
main
