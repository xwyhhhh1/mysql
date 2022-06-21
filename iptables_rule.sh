#!/bin/bash

#社区版蓝鲸相关ip
if [ -d /data/bkce ] ;then
   IPTATABLES_PATH=$(which iptables)
   LIST_IP=$(cat /data/install/install.config | awk '{print $1}' | grep -Ev "^\[" | grep -Ev "^$" | sort | uniq)
   LOCAL_HOST_IP_1=$(echo $LIST_IP | awk '{print $1}')
   LOCAL_HOST_IP_2=$(echo $LIST_IP | awk '{print $2}')
   LOCAL_HOST_IP_3=$(echo $LIST_IP | awk '{print $3}')
   CONTROLLER_IP=$(cat /data/install/.controller_ip)
   NGINX_IP=$(grep nginx /data/install/install.config | awk '{print $1}')
   NODEMAN_IP=$(grep nodeman /data/install/install.config | awk '{print $1}')
   HOTS_IP=$(hostname -I)
else
  echo "非标准的蓝鲸安装,本脚本暂不支持"
fi
#根据机器模块的不同添加防火墙规则
if [ $CONTROLLER_IP = $HOTS_IP ] ;then
   #中控机防火墙规则
   $IPTATABLES_PATH -I INPUT -s $LOCAL_HOST_IP_1 -p all -j ACCEPT
   $IPTATABLES_PATH -I INPUT -s $LOCAL_HOST_IP_2 -p all -j ACCEPT
   $IPTATABLES_PATH -I INPUT -s $LOCAL_HOST_IP_3 -p all -j ACCEPT
   $IPTATABLES_PATH -I INPUT -p tcp --dport 22 -j ACCEPT
   $IPTATABLES_PATH -I INPUT -p tcp --dport 48533 -j ACCEPT
   $IPTATABLES_PATH -I INPUT -p tcp --dport 58625 -j ACCEPT
   $IPTATABLES_PATH -I INPUT -p tcp --dport 59173 -j ACCEPT
   $IPTATABLES_PATH -I INPUT -p tcp --dport 10020 -j ACCEPT
   $IPTATABLES_PATH -I INPUT -p udp --dport 10020 -j ACCEPT
   $IPTATABLES_PATH -I INPUT -p udp --dport 10030 -j ACCEPT
   $IPTATABLES_PATH -I INPUT -p tcp --dport 60020:60030 -j ACCEPT
   $IPTATABLES_PATH -I INPUT -p udp --dport 60020:60030 -j ACCEPT
   $IPTATABLES_PATH -I INPUT -p tcp --dport 58930 -j ACCEPT
   $IPTATABLES_PATH -I INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
   $IPTATABLES_PATH -I OUTPUT -p all -j ACCEPT
   $IPTATABLES_PATH -A INPUT -p tcp -j DROP
else
   echo "非中控机" 
fi
if [ $NGINX_IP = $HOTS_IP ] ;then
   #nginx模块防火墙规则
   $IPTATABLES_PATH -I INPUT -s $LOCAL_HOST_IP_1 -p all -j ACCEPT
   $IPTATABLES_PATH -I INPUT -s $LOCAL_HOST_IP_2 -p all -j ACCEPT
   $IPTATABLES_PATH -I INPUT -s $LOCAL_HOST_IP_3 -p all -j ACCEPT
   $IPTATABLES_PATH -I INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
   $IPTATABLES_PATH -I INPUT -p tcp --dport 22 -j ACCEPT
   $IPTATABLES_PATH -I INPUT -p udp --dport 80 -j ACCEPT
   $IPTATABLES_PATH -I INPUT -p udp --dport 443 -j ACCEPT
   $IPTATABLES_PATH -I OUTPUT -p all -j ACCEPT
   $IPTATABLES_PATH -A INPUT -p tcp -j DROP
else
   echo "非nginx机器"
fi
if [ $NODEMAN_IP = $HOTS_IP ] ;then
   #nodeman模块防火墙规则
   $IPTATABLES_PATH -I INPUT -s $LOCAL_HOST_IP_1 -p all -j ACCEPT
   $IPTATABLES_PATH -I INPUT -s $LOCAL_HOST_IP_2 -p all -j ACCEPT
   $IPTATABLES_PATH -I INPUT -s $LOCAL_HOST_IP_3 -p all -j ACCEPT
   $IPTATABLES_PATH -I INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
   $IPTATABLES_PATH -I INPUT -p tcp --dport 22 -j ACCEPT
   $IPTATABLES_PATH -I INPUT -p udp --dport 80 -j ACCEPT
   $IPTATABLES_PATH -I INPUT -p udp --dport 443 -j ACCEPT
   $IPTATABLES_PATH -I OUTPUT -p all -j ACCEPT
   $IPTATABLES_PATH -A INPUT -p tcp -j DROP
else
   echo "非nodeman机器"
fi 
