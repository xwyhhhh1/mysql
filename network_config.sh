#! /bin/bash

IP_ADDR=`hostname -I`
NETMAS_ADDR='172.17.20.1'

NET_DIR='/etc/sysconfig/network-scripts'

cd $NET_DIR
NET_NAME=`ls ifcfg*|grep -v *lo`
cp $NET_NAME  $NET_NAME.ori

sed -i 's#BOOTPROTO="dhcp"#BOOTPROTO="static"#g' ${NET_DIR}/${NET_NAME}
grep  IPADDR  $NET_NAME
if [ $? -ne 0 ]
then
   echo 'IPADDR="172.17.20.176"' >> $NET_NAME
else
   sed -i 's#IPADDR=#IPADDR="172.17.20.176#g' ${NET_DIR}/${NET_NAME}
fi
#netmask
#gateway
#dns1
sed -i ''

ifup  ifdwon 

if
then
fi