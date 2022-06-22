#!/bin/bash
read -t 60 -p "proxy_lan_ip: " BLUEKING_PROXY_LAN
read -t 60 -p "P-agent_lan_ip: " BLUEKING_P_AGENT
if [ $(id -u) -eq 0 ] ;then
   echo "<============>Current user is root,running.........<=============>"
   iptables -I INPUT -s $BLUEKING_P_AGENT -d $BLUEKING_PROXY_LAN -p tcp --dport 48533 -j ACCEPT
   iptables -I INPUT -p tcp --dport 22 -j ACCEPT
   iptables -I INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
   iptables -I INPUT -p tcp --dport 17980:17981 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_P_AGENT -d $BLUEKING_PROXY_LAN -p tcp --dport 58625 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_P_AGENT -d $BLUEKING_PROXY_LAN -p tcp --dport 59173 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_P_AGENT -d $BLUEKING_PROXY_LAN -p tcp --dport 10020 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_P_AGENT -d $BLUEKING_PROXY_LAN -p udp --dport 10020 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_P_AGENT -d $BLUEKING_PROXY_LAN -p udp --dport 10030 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_P_AGENT -p udp --dport 60020:60030 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_P_AGENT -p tcp --dport 60020:60030 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_P_AGENT -d $BLUEKING_P_AGENT -p udp --dport 60020:60030 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_P_AGENT -d $BLUEKING_P_AGENT -p tcp --dport 60020:60030 -j ACCEPT
   iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_P_AGENT -p tcp --dport 80 -j ACCEPT
   iptables -I OUTPUT -p all -j ACCEPT
   iptables -A INPUT -p all -j DROP
   echo "<============>SUCCESS!!!<=============>"

else
   echo "<============>User is not root,stoping.........<=============>"
   exit 1;
fi