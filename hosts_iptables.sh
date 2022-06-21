#!/bin/bash
read -t 60 -p "local_hosts_ip_1 : " HOSTS_IP_1
read -t 60 -p "local_hosts_ip_2 : " HOSTS_IP_2
read -t 60 -p "local_hosts_ip_3 : " HOSTS_IP_3
read -t 60 -p "hosts_ip_wan or not : " WAN_HOSTS_IP

iptables -I INPUT -s $local_hosts_ip_1 -p all -j ACCEPT
iptables -I INPUT -s $local_hosts_ip_2 -p all -j ACCEPT
iptables -I INPUT -s $local_hosts_ip_3 -p all -j ACCEPT

iptables -A INPUT -p all -j DROP


