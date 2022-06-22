#!/bin/bash
#variable
read -t 60 -p "proxy_wan_ip: " BLUEKING_PROXY
read -t 60 -p "gse_wan_ip: " BLUEKING_GSE_SERVER
read -t 60 -p "proxy_lan_ip: " BLUEKING_PROXY_LAN
IPT=/user/sbin/iptables

if [ $(id -u) -eq 0 ] ;then
   echo "<============>Current user is root,running.........<=============>"
   #proxy
   $IPT -I INPUT -p tcp --dport 17980:17981 -j ACCEPT
   $IPT -I INPUT -p tcp --dport 80 -j ACCEPT
   $IPT -I INPUT -p tcp --dport 10020 -j ACCEPT
   $IPT -I INPUT -p udp --dport 10020 -j ACCEPT
   $IPT -I INPUT -p tcp --dport 10030 -j ACCEPT
   $IPT -I INPUT -p tcp --dport 58625 -j ACCEPT
   $IPT -I INPUT -p tcp --dport 59173 -j ACCEPT
   $IPT -I INPUT -p tcp --dport 48533 -j ACCEPT
   $IPT -I INPUT -p tcp --dport 22 -j ACCEPT
   $IPT -I INPUT -p tcp --dport 443 -j ACCEPT
   $IPT -I INPUT -s $BLUEKING_GSE_SERVER -p tcp --dport 2181 -j ACCEPT
   $IPT -I INPUT -d $BLUEKING_PROXY_LAN -p tcp --dport 60020:60030 -j ACCEPT
   $IPT -I INPUT -d $BLUEKING_PROXY_LAN -p udp --dport 60020:60030 -j ACCEPT
   $IPT -I INPUT -s $BLUEKING_PROXY -p tcp --dport 58930 -j ACCEPT
   $IPT -I INPUT -s $BLUEKING_PROXY_LAN -p tcp --dport 58930 -j ACCEPT
   $IPT -I INPUT -s $BLUEKING_GSE_SERVER -p tcp --dport 58930 -j ACCEPT
   $IPT -I INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
   $IPT -A INPUT -p all -j DROP
   $IPT -A INPUT -p all -j ACCEPT
   echo "<============>SUCCESS!!!<=============>"

else
   echo "<============>User is not root,stoping.........<=============>"
   exit 1;
fi
