#!/bin/bash
#user: xwyhhhh1
#Email: bianhao6636@163.com

TELNET_IP="192.168.0.193"

USAGE(){
   echo "usage error,Please refer to the following usage"
   echo "xxx.sh [ports]"
}

TELNET_PORT(){
   if which telnet > /dev/null 2>&1 ;then
      for i in $@
      do
         result=$(echo -e "\n" | telnet $TELNET_IP $i 2>/dev/null | grep Connected | wc -l)
         if [ $result -ge 1 ] ;then
            echo "$i connection !!"
         else
            echo "$i not connection"
         fi
      done
   else
      timeout 10s yum -y install telnet
   fi
   
}
if [[ $TELNET_IP == "" ]] ;then 
   echo "TELNET_IP Is empty"
   exit 1;
else
   if [ $# -ge 1 ] ;then
      TELNET_PORT "$@"
   else
      USAGE
   fi
fi

