#!/bin/bash
ip_number=ip a | grep -E "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | awk '{print $2}' | awk -F '/' '{print $1}' | wc -l
if [ $ip_number -le 3  ] ;then
   ip1=ip a | grep -E "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | awk '{print $2}' | awk -F '/' '{print $1}' | awk 'NR==1{print}'
   ip2=ip a | grep -E "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | awk '{print $2}' | awk -F '/' '{print $1}' | awk 'NR==2{print}'
   ip3=ip a | grep -E "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | awk '{print $2}' | awk -F '/' '{print $1}' | awk 'NR==3{print}'
   [ "$ip3" = "" ] && echo  || echo "此ip值为空,若您除了了本机回环地址,另有两张网卡请注意此值" ; read -t 60 -p "还要继续吗? yes or no : " YES
   [ $YES = yes ] && echo "即将继续......." || echo "停止中......." ; exit 1





fi