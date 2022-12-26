#!/bin/bash
#user:xwyhhh1
#mail:2293558627@qq.com
#Variable
OPRESTY_PATH=/usr/local/openresty
OPENRESTY_SRC=/usr/local/src/
OPRENRETY_DOWLOAD=/usr/local/src/openresty-1.19.9.1
WGET_OPENRESTY=openresty-1.19.9.1.tar.gz
#install perl pcre openssl c readline
echo "install perl pcre openssl c readline......... "
yum -y install perl-devel readline-devel pcre-devel openssl-devel gcc gcc-c++
cd $OPENRESTY_SRC
echo "dowloads operesty-1.19.9........"
wegt https://openresty.org/download/openresty-1.19.9.1.tar.gz
echo "decompression openresty......."
tar -xf $WGET_OPENRESTY -C $OPENRESTY_SRC
cd $OPRENRETY_DOWLOAD
#compile openresty
./configure --prefix=$OPRESTY_PATH
if [ $? -eq 0 ] ;then
   make && make install
else
   echo "configure file"
   exit 1;
fi
$OPRESTY_PATH/nginx/sbin/nginx