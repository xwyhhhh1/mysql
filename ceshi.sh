#!/bin/bash

profile () {
  echo "installing rely on...."
  yum -y install gcc gcc-c++ pcre wget openssl openssl-devel libtool gd gd-devel
  echo "dowload nginx_1.18......"
  cd /usr/local/src && wget https://nginx.org/download/nginx-1.18.0.tar.gz
  useradd nginx -s /sbin/nologin
}
install () {
    tar -xf nginx-1.18.0.tar.gz -C /usr/local/src
    cd /usr/local/src/nginx-1.18.0
    ./configure --prefix=/usr/local/nginx --user=nginx --group=nginx  --with-http_ssl_module  --with-http_stub_status_module --with-http_gzip_static_module --with-http_image_filter_module >> /dev/null
    if [ $? == 0 ] ;then
       make >> /dev/null && make install >> /dev/null
       cd /usr/local/nginx/sbin && ./nginx || /usr/local/nginx/sbin/nginx
    fi
}
check () {
   yum -y install net-tools >> /dev/null
   NGINX_PORT=$(netstat -tnulp | grep nginx | wc -l)
   NGINX_PROC=$(ps -aux | grep -v grep | grep nginx | wc -l)
   [ $NGINX_PORT -ge 1 ] && echo "端口存在" || echo "端口不存在"
   [ $NGINX_PROC -ge 1 ] && echo "进程存在" || echo "进程不存在"

}
profile
install
check
echo "Install Success!"