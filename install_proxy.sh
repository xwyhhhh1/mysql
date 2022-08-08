#!/bin/bash
#variable
read -t 60 -p "proxy_wan_ip: " BLUEKING_PROXY
read -t 60 -p "gse_wan_ip: " BLUEKING_GSE_SERVER
read -t 60 -p "proxy_lan_ip: " BLUEKING_PROXY_LAN

#CMD
iptables -I INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p tcp -m tcp --dport 2181 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p tcp -m tcp --dport 6379 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p tcp -m tcp --dport 48533 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p tcp -m tcp --dport 59173 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p tcp -m tcp --dport 58625 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p tcp -m tcp --dport 58930 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p tcp -m tcp --dport 10020 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p udp -m udp --dport 10020 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p udp -m udp --dport 10030 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p tcp -m tcp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY -d $BLUEKING_GSE_SERVER -p udp -m udp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_GSE_SERVER -p tcp -m tcp --dport 48533 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_GSE_SERVER -p tcp -m tcp --dport 59173 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_GSE_SERVER -p tcp -m tcp --dport 58625 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_GSE_SERVER -p tcp -m tcp --dport 58930 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_GSE_SERVER -p tcp -m tcp --dport 10020 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_GSE_SERVER -p udp -m udp --dport 10020 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_GSE_SERVER -p udp -m udp --dport 10030 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_GSE_SERVER -p tcp -m tcp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_GSE_SERVER -p udp -m udp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY_LAN -p tcp -m tcp --dport 48533 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY_LAN -p tcp -m tcp --dport 59173 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY_LAN -p tcp -m tcp --dport 58625 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY_LAN -p tcp -m tcp --dport 58930 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY_LAN -p tcp -m tcp --dport 10020 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY_LAN -p udp -m udp --dport 10020 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY_LAN -p udp -m udp --dport 10030 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY_LAN -p tcp -m tcp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY_LAN -p udp -m udp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY -p tcp -m tcp --dport 48533 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY -p tcp -m tcp --dport 59173 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY -p tcp -m tcp --dport 58625 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY -p tcp -m tcp --dport 58930 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY -p tcp -m tcp --dport 10020 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY -p udp -m udp --dport 10020 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY -p udp -m udp --dport 10030 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY -p tcp -m tcp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -s $BLUEKING_GSE_SERVER -d $BLUEKING_PROXY -p udp -m udp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_PROXY_LAN -p tcp -m tcp --dport 48533 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_PROXY_LAN -p tcp -m tcp --dport 59173 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_PROXY_LAN -p tcp -m tcp --dport 58625 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_PROXY_LAN -p tcp -m tcp --dport 58930 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_PROXY_LAN -p tcp -m tcp --dport 10020 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_PROXY_LAN -p udp -m udp --dport 10020 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_PROXY_LAN -p udp -m udp --dport 10030 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_PROXY_LAN -p tcp -m tcp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -s $BLUEKING_PROXY_LAN -d $BLUEKING_PROXY_LAN -p udp -m udp --dport 60020:60030 -j ACCEPT
iptables -A INPUT -j DROP
iptables -A OUTPUT -j ACCEPT