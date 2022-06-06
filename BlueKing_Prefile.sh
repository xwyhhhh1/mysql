#!/bin/bash
read -t 20 -p "hostname: " a
#variable
BACKUP_PATH=/root/backup
YUM_PATH=/etc/yum.repos.d
IPV6_CONFIG=/etc/sysctl.conf
if [ $USER != "root" ]; then
echo "YOU need root implement"
exit 1
fi

echo "<============>close NetworkManager<=============>"
systemctl stop NetworkManager && systemctl disable NetworkManager
echo "<============>close Filewalld<=============>"
systemctl stop firewalld && systemctl disable firewalld
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config && setenforce 0
echo "<============>close ipv_6<=============>"
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> $IPV6_CONFIG
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> $IPV6_CONFIG
sysctl -p
yum -y install epel-release
if [ $? -eq 0 ]; then
   if [ ! -d $BACKUP_PATH ]; then
      mkdir $BACKUP_PATH
      mv $YUM_PATH/* $BACKUP_PATH
   else
      mv $YUM_PATH/* $BACKUP_PATH
   fi
else
   echo "install epel-release fail"
   exit 1
fi
cd $YUM_PATH
echo "<============>modify yum<=============>"
curl -O http://mirrors.aliyun.com/repo/Centos-7.repo && mv ${YUM_PATH}/Centos-7.repo ${YUM_PATH}/CentOS-Base.repo
if [ $? -eq 0 ]; then
   curl -O http://mirrors.aliyun.com/repo/epel-7.repo && mv ${YUM_PATH}/epel-7.repo ${YUM_PATH}/epel.repo
fi
echo "<============>clean cache<=============>"
yum clean all
echo "<============>make cache<=============>"
yum makecache fast
which rsync >> /dev/null 2>&1 
if [ $? -eq 0 ] ; then
    echo "<============>rsync installed<=============>"
else
   yum -y install rsync
   echo "<============>installing rsync<=============>"
fi
which pssh >> /dev/null 2>&1 
if [ $? -eq 0 ] ; then
    echo "<============>pssh installed<=============>"
else
   yum -y install pssh
   echo "<============>install pssh<=============>"
fi
echo "root soft nofile 102400" >> /etc/security/limits.conf
echo "root hard nofile 102400" >> /etc/security/limits.conf
yum -y install ntpdate > /dev/null 2>&1
echo "<============>update time<=============>"
if [ $? -eq 0 ]; then
   ntpdate time.windows.com
   echo "<============>update time yes<=============>"
else
   echo "Time synchronization failure"
   exit 1
fi
hostnamectl set-hostname $a
echo "<============>Ready to log out<=============>"
sleep 10
echo "success!"

