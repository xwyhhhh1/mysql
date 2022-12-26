#!/bin/bash
Nginx_Master=$(ps -aux | grep -E 'nginx: master' | grep -v 'grep' | wc -l)
Nginx_Worker=$(ps -aux | grep -E 'nginx: worker' | grep -v 'grep' | wc -l)
Nginx_Port=$(netstat -tnulp | grep nginx | wc -l)
Nginx_Path=/usr/local/nginx
Nginx_Pid=${Nginx_Path}/logs/nginx.pid

check(){
###### process check
   if [ $Nginx_Master -ge 1 ] ;then
      if [ $Nginx_Worker -ge 1 ] ;then
         if [ -f $Nginx_Pid ] ;then
            # echo "process existence"
            /usr/bin/true
         else
            # echo "nginx.pid not exits,but process existence,Service exception!!!!" && /usr/bin/false
            /usr/bin/false
         fi
      else
            # echo "Process does not exist, service exception " && /usr/bin/false
            /usr/bin/false
      fi
   fi
   reture_process=$?
###### port check
   if [ $Nginx_Port -ge 1 ] ;then
      #    echo "The nginx port exists"
      #    echo "The number of ports is ${Nginx_Port}"
      /usr/bin/true
   else  
      # echo "port does not exits!!!! " && /usr/bin/false    
      /usr/bin/false
   fi   
   reture_prot=$?       
}
start(){
   # restart 
   # 改进
   $Nginx_Path/sbin/nginx
}
main(){
   check
   sleep 3
   if [ $reture_process -eq 0 -a $reture_prot -eq 0 ] ;then
      sleep 3 
   else
      systemctl stop keepalived
      start
      sleep 3
   fi
}

### function call

main