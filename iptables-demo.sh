#! /bin/bash

# Auth: Tyrone.Zhao
# Date: 20220-06-23
# Desc: iptables test

#!/bin/bash
ipt="/usr/sbin/iptables"
$ipt -F 
$ipt -P INPUT DROP
$ipt -P OUTPUT ACCEPT
$ipt -P FORWARD ACCEPT
$ipt -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT 
#增加上面规则，为通信更顺畅！
$ipt -A INPUT -s 192.168.133.0/24 -p tcp --dport 22 -j ACCEPT
$ipt -A INPUT -p tcp --dport 80 -j ACCEPT
$ipt -A INPUT -p tcp --dport 21 -j ACCEPT
# icmp 
# iptables -I INPUT -p icmp --icmp-type 8 -j DROP