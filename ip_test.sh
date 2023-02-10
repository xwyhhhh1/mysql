#!/bin/bash
Network_Path=/etc/sysconfig/network-scripts
BOND_IP=("10.2.16.11" "10.2.8.59" "10.2.18.11")
profile () {
    [ -d  ${Network_Path}/bak ] || mkdir -p ${Network_Path}/bak
    mount /dev/sr0 ${Network_Path}/bak && echo "mount success!!" || echo "mount fialed"
    local Bond_Number=$(ls ${Network_Path}/bak/*/ | grep ifcfg-bond.* | wc -l)
    [ $Bond_Number -ge 4 ] || echo "The wrong image is mounted"
}
storage_modify () {
    cd $Network_Path
    # cp ${Network_Path}/bak/storage/ifcfg-bond* ./
    cp -a ${Network_Path}/bak/*/ifcfg-bond* ./
    local Bond_Number=$(ls -t ./ifcfg-bond*\.*)
    read -a BOND_NUMBER <<< $Bond_Number 
 #   let a=${#BOND_IP[@]}-1
 #   for i in {0..$a} #此种for循环不支持变量,废弃
    for ((i=0;i<${#BOND_IP[@]};i++))
    do
       sed -i "/IPADDR=.*/c IPADDR=${BOND_IP[$i]}" ${BOND_NUMBER[$i]}
    done
    
}
roolback () {
    cd $Network_Path
    if [ -d $Network_Path/bak ] ;then
        umount ${Network_Path}/bak
        rm -rf bak
    else
        echo "bak failed"
    fi
    [ $(ls | grep ifcfg-bond.* | wc -l) -gt 0  ] && rm -rf ifcfg-bond* || echo "bond file filed"

}

usage () {
    echo "xxx.sh [--s/--d]"
}
case $1 in
    --s)
        if [ ! -n "$BOND_IP" ] ;then
            echo "bondip is null"
            exit 2
        else
            profile
            storage_modify
        fi
       ;;
    --drop)
        roolback
        ;;
    *)
    usage
esac
