#!/bin/bash
read -t 60 -p "proxy_wan_ip: " BLUEKING_PROXY
read -t 60 -p "gse_wan_ip: " BLUEKING_GSE_SERVER
read -t 60 -p "nodeman_wan_ip: " BLUEKING_NODEMAN_SERVER
if [ $(id -u) -eq 0 ] ;then
   echo "<============>Current user is root,running.........<=============>"
   #proxy-gse
   iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p tcp --dport 48533 -j ACCEPT
   ptables -I INPUT -p tcp --dport 22 -j ACCEPT
   iptables -I INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
   iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p tcp --dport 58625 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p tcp --dport 58930 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p tcp --dport 10020 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p udp --dport 10020 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p udp --dport 10030 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY -p tcp --dport 58930 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY -p tcp --dport 10020 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY -p udp --dport 10020 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY -p udp --dport 10030 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_PROXY -p tcp --dport 58930 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_PROXY -p tcp --dport 10020 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_PROXY -p udp --dport 10020 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_PROXY -p udp --dport 10030 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p tcp --dport 58725 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_NODEMAN_SERVER -d $BLUEKING_PROXY -p tcp --dport 80 -j ACCEPT
   iptables -I OUTPUT -p all -j ACCEPT
   iptables -A INPUT -p all -j DROP 
   echo "<============>SUCCESS!!!<=============>"

else
   echo "<============>User is not root,stoping.........<=============>"
   exit 1;
fi
