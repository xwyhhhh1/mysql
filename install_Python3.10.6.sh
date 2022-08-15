#!/bin/bash
WGET_PATH=/usr/local/src
OPENSSL_URL=https://www.openssl.org/source/openssl-1.1.1q.tar.gz
PYTHON_URL=https://www.python.org/ftp/python/3.10.6/Python-3.10.6.tgz
PYTHON_PAGE=Python-3.10.6.tgz
OPENSSL_PAGE=openssl-1.1.1q.tar.gz
wget_() {
    ping www.baidu.com -c 3 > /dev/null 2>&1
    if [ $? -eq 0 ] ;then
        echo "
        download Python 3.10.6.....
        download openssl 1.1.1q....
        "
        cd $WGET_PATH         
        wget $PYTHON_URL
        wget $OPENSSL_URL --no-check-certificate
        yum -y install gcc gcc-c++ zlib-devel perl-devel libtools-devel openssl_devel
    else
        echo "网络故障,请求失败"
    fi
}
openssl_install() {
    echo "
    taring python....
    taring openssl....
    "
    tar -xf $PYTHON_PAGE -C $WGET_PATH
    tar -xf $OPENSSL_PAGE -C $WGET_PATH
    if [ $? -eq 0 ] ;then
        cd ${WGET_PATH}/openssl-1.1.1q
        ./config --prefix=/usr/local/openssl
        make && make install
        [ $? -eq 0 ] && echo "openssl编译成功" || exit 1;
        ln -s /usr/local/openssl/lib/libssl.so.1.1  /usr/lib64/libssl.so.1.1
        ln -s /usr/local/openssl/lib/libcrypto.so.1.1  /usr/lib64/libcrypto.so.1.1
    fi
}
python_install() {
    echo "
    install python.......
    "
    cd ${WGET_PATH}/Python-3.10.6
    sed -i "207s/#//" /usr/local/src/Python-3.10.6/Modules/Setup
    sed -i "212 s:^#:OPENSSL=/usr/local/openssl\n:" /usr/local/src/Python-3.10.6/Modules/Setup 
    sed -i "212,218s/#//" /usr/local/src/Python-3.10.6/Modules/Setup
    ./configure --prefix=/usr/local/Python-3.10.6/ --with-openssl=/usr/local/openssl/
    make && make install
    if [ $? -eq 0 ] ;then
        echo "export PATH=$PATH:/usr/local/Python-3.10.6/bin" >> /etc/profile
        source /etc/profile
        python3 -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple/
        echo "python安装成功"
    else
        echo "python安装失败"
    fi
}
wget_
openssl_install
python_install
