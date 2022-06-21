#!/bin/bash
read -t 60 -p "agent_ip: " BLUEKING_AGENT
BLUEKING_GSE_SERVER=10.10.9.30
BLUEKING_ZOOKEEPER_SERVER=10.10.9.32
BLUEKING_NODEMAN_SERVER=10.10.9.32
if [ $(id -u) -eq 0 ] ;then
   echo "<============>Current user is root,running.........<=============>"
   /usr/sbin/iptables -I INPUT -s $BLUEKING_AGENT -d $BLUEKING_ZOOKEEPER_SERVER -p tcp --dport 2181 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_AGENT -d $BLUEKING_GSE_SERVER -p tcp --dport 48533 -j ACCEPT
   iptables -I INPUT -p tcp --dport 22 -j ACCEPT
   iptables -I INPUT -p tcp --dport 443 -j ACCEPT 
   iptables -I INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
   iptables -I INPUT -s $BLUEKING_AGENT -d $BLUEKING_GSE_SERVER -p tcp --dport 58625 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_AGENT -d $BLUEKING_GSE_SERVER -p tcp --dport 59173 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_AGENT -d $BLUEKING_GSE_SERVER -p tcp --dport 10020 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_AGENT -d $BLUEKING_GSE_SERVER -p udp --dport 10020 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_AGENT -d $BLUEKING_GSE_SERVER -p udp --dport 10030 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_AGENT -p udp --dport 60020:60030 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_AGENT -p tcp --dport 60020:60030 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_GSE_SERVER -p tcp --dport 58930 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_GSE_SERVER -p tcp --dport 10020 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_GSE_SERVER -p udp --dport 10020 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_GSE_SERVER -p udp --dport 10030 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_AGENT -d $BLUEKING_AGENT -p tcp --dport 60020:60030 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_AGENT -d $BLUEKING_AGENT -p udp --dport 60020:60030 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_NODEMAN_SERVER -d $BLUEKING_AGENT -p tcp --dport 80 -j ACCEPT
   iptables -I OUTPUT -p all -j ACCEPT
   iptables -A INPUT -p all -j DROP 
   echo "<============>SUCCESS!!!<=============>"

else
   echo "<============>User is not root,stoping.........<=============>"
   exit 1;
fi