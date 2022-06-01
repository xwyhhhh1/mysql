#!/bin/bash
#email: 2293558627@qq.com
#version: 1.0
#auth: xwy
#des: check web status

APACHE_PROCES=$(ps -aux | grep httpd | wc -l)
APACHE_PORT=$(netstat -tnulp | grep httpd | wc -l)

if [ $APACHE_PROCES -ge 2 ] && [ $APACHE_PORT -ge 2 ] ;then
    echo "apache proces stock"
    echo "apache port stock"
else
    echo "pcoces error or port error"
fi