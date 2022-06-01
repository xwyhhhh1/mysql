#! /bin/bash

host_list=`cat /data/install/install.config|awk '{print $1}'`

for i  in  $host_list
do
   ssh $i  -C ntpdate time.asia.apple.com 
done


for i  in  `cat /data/instal/install.config|awk '{print $1}'`
do
   ssh $i  -C ntpdate time.asia.apple.com 
done


for i in `cat /data/install/install.config|awk '{print $1}'`;do ssh $i -C nptdate time.asia.apple.com ;done 
