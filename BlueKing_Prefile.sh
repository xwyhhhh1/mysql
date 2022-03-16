#!/bin/bash
read -t 20 -p "hostname: " a
systemctl stop firewalld && systemctl disable firewalld > /dev/null
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config && setenforce 0
yum install -y epel-release > /dev/null 2>&1
if [ $? -eq 0 ]; then
   if [ -d /root/backup ]; then
      mv /etc/yum.repos.d/* /root/backup
   else
      echo 'You need cmd mkdir /root/backup'
      exit 1;
   fi
else
   echo "install epel-release fail"
   exit 1
fi
cd /etc/yum.repos.d/
echo "<============>modify yum source<=============>"
curl -O http://mirrors.aliyun.com/repo/Centos-7.repo && mv /etc/yum.repos.d/Centos-7.repo /etc/yum.repos.d/CentOS-Base.repo
if [ $? -eq 0 ]; then
   curl -O http://mirrors.aliyun.com/repo/epel-7.repo && mv /etc/yum.repos.d/epel-7.repo /etc/yum.repos.d/epel.repo
fi
yum clean all > /dev/null 2>&1
yum makecache fast > /dev/null 2>&1
which rsync > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "<============>rsync installed<=============>"
else
   echo "<============>installing rsync<=============>"
   yum -y install rsync
fi
echo "root soft nofile 102400" >> /etc/security/limits.conf
echo "root hard nofile 102400" >> /etc/security/limits.conf
yum -y install ntpdate > /dev/null 2>&1
echo "<============>update time<=============>"
if [ $(echo $?) -eq 0 ]; then
   ntpdate time.windows.com > /dev/null 2>&1
   echo "<============>update time yes<=============>"
else
   echo "Time synchronization failure"
   exit 1
fi
hostnamectl set-hostname $a
echo "<============>Ready to log out<=============>"
sleep 5
reboot

