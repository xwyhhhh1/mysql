#!/bin/bash
#version: 1.0
#email: 2293558627@qq.com
read -t 10 -p "ip: " IP
NETWOEK_FILE=$(find /etc/sysconfig/network-scripts/ -type f -name "ifcfg*" | awk -F "/" 'NR==2{print $5}')
=/etc/sysconfig/network-scripts/$NETWOEK_FILE
mv /etc/sysconfig/network-scripts/$NETWOEK_FILE /etc/sysconfig/network-scripts/${NETWOEK_FILE}.bak
cat < EOF >>

cd /etc/sysconfig/network-scripts/
