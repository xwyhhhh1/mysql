#/bin/bash
#version:1.0
#email:2293558627@qq.com
PHP_PATH=/usr/local/php
LIBZIP_PATH=/usr/local/libzip
DOWNLOAD_PATH=/usr/local/src
LIBZIP_NAME=/usr/local/src/libzip
PHP_NAME=/usr/local/src/php
profile_fist () {
    echo "<========>install rely<========>"
    yum -y install gcc gcc-c++ gd gd-devel libxml2-devel unzip sqlite-devel libcurl libcurl-devel oniguruma-devel pcre-devel perl perl-devel bison-devel re2c wget vim
    id nginx > /dev/null 2>&1
    if [ $? -eq 0 ] ; then
       echo "user nginx existence"
    else
       useradd nginx -s /sbin/nologin
    fi
}
 profile_sencd() {
    cd $DOWNLOAD_PATH
    echo "<========download libzip-1.2.0========>"
    wget https://libzip.org/download/libzip-1.2.0.tar.gz --no-check-certificate
    echo "<========>download php-7.4.24<========>"
    wget https://www.php.net/distributions/php-7.4.24.tar.gz
    echo "<========>Decompressing please wilt<========>"
    tar -xf libzip-1.2.0.tar.gz
    mv libzip-1.2.0 libzip
    tar -xf php-7.4.24.tar.gz
    mv php-7.4.24 php
}
install_libzip () {
    cd $LIBZIP_NAME
    echo "<========>configure ing......<========>"
    ./configure --prefix=${LIBZIP_PATH}
    sleep 10
    echo "<========>makeing......<========>"
    make && make install
    if [ $? -eq 0 ] ; then
       echo "<========>install libzip success<========>"
    else
       echo "<========>install libzip fail<========>"
       exit 1;
    fi
    echo "export PKG_CONFIG_PATH=${LIBZIP_PATH}/lib/pkgconfig/" >> /etc/profile && source /etc/profile
}
install_php () {
    cd $PHP_NAME
    echo "<========>configure ing......<========>"
    ./configure --prefix=${PHP_PATH} --with-fpm-user=nginx --with-fpm-group=nginx --with-zlib --with-pdo-mysql=mysqlnd  --enable-mysqlnd --with-curl --with-jpeg --with-xpm --enable-fpm --enable-ftp --enable-gd --enable-mbstring --enable-sockets  --with-zip --with-pcre-jit
    sleep 10
    echo "<========>makeing......<========>"
    make && make install
    if [ $? -eq 0 ] ; then
       echo "<========>install php success!!!!!<========>"
       sleep 3
       echo "<========>config generate.........<========>"
       cd ${PHP_PATH}/etc/
       cp php-fpm.conf.default php-fpm.conf
       cp ${PHP_NAME}/php.ini-production ${PHP_PATH}/etc/php.ini
       mv ./php-fpm.d/www.conf.default ./php-fpm.d/www.conf
       ../sbin/php-fpm
       [ $? -eq 0 ] && echo "php-fpm start sucess!!" || echo "php-fpm start error!!"
    else
       echo "<========>install php fail<========>"
       exit 1;
    fi
}
profile_fist
profile_sencd
install_libzip
install_php