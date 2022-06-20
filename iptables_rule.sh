#!/bin/bash
if [ -d /data/bkce ] ;then
   IPTATABLES_PATH=$(which iptables)
   LIST_IP=$(cat /data/install/install.config | awk '{print $1}' | grep -Ev "^\[" | grep -Ev "^$" | sort | uniq)
   LOCAL_HOST_IP_1=$(echo $LIST_IP | awk '{print $1}')
   LOCAL_HOST_IP_2=$(echo $LIST_IP | awk '{print $2}')
   LOCAL_HOST_IP_3=$(echo $LIST_IP | awk '{print $3}')
   CONTROLLER_IP=$(cat /data/install/.controller_ip)
   NGINX_IP=$(grep nginx /data/install/install.config | awk '{print $1}')
   NODEMAN_IP=$(grep nodeman /data/install/install.config | awk '{print $1}')
else
  echo "非标准的蓝鲸安装,本脚本暂不支持"
fi
iptables_add () {
   for i in $LIST_IP
   do
      if [[ $CONTROLLER_IP == $i ]] ;then
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
      elif [[ $NGINX_IP == $i ]] ;then
         $IPTATABLES_PATH -I INPUT -s $LOCAL_HOST_IP_1 -p all -j ACCEPT
         $IPTATABLES_PATH -I INPUT -s $LOCAL_HOST_IP_2 -p all -j ACCEPT
         $IPTATABLES_PATH -I INPUT -s $LOCAL_HOST_IP_3 -p all -j ACCEPT
         $IPTATABLES_PATH -I INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
         $IPTATABLES_PATH -I INPUT -p tcp --dport 22 -j ACCEPT
         $IPTATABLES_PATH -I INPUT -p udp --dport 80 -j ACCEPT
         $IPTATABLES_PATH -I INPUT -p udp --dport 443 -j ACCEPT
         $IPTATABLES_PATH -I OUTPUT -p all -j ACCEPT
         $IPTATABLES_PATH -A INPUT -p tcp -j DROP
       elif [[ $NODEMAN_IP == $i ]] ;then
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
         echo "不与任何ip匹配,建议检查变量"
         exit 1;
      fi
   done
}
iptables_add