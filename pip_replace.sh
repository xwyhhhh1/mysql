#!/bin/bash
cat << EOF
Please select a parameter
1==>aliyun
2==>qinghua
3==>kejidaxue
4==>douban
EOF
read -t "10" -p "url: " REPLACE
[ ! -d /root/.pip ] && mkdir /root/.pip || echo '.pip已存在,正在更改文件'
case  "$REPLACE" in
    1)
        echo " " > /root/.pip/pip.conf
        echo "[global]" >> /root/.pip/pip.conf
        echo "index-url = https://mirrors.aliyun.com/pypi/simple" >> /root/.pip/pip.conf
        echo "<==========>更改源为阿里源<==========>"
        ;;
    2)
        echo " " > /root/.pip/pip.conf
        echo "[global]" >> /root/.pip/pip.conf
        echo "index-url = https://pypi.tuna.tsinghua.edu.cn/simple" >> /root/.pip/pip.conf
        echo "<==========>更改源为清华源<==========>"
        ;;
    3)
        echo " " > /root/.pip/pip.conf
        echo "[global]" >> /root/.pip/pip.conf
        echo "index-url = http://pypi.douban.com/simple/" >> /root/.pip/pip.conf
        echo "<==========>更改源为中国科技大学源<==========>"
        ;;
    4)
        echo " " > /root/.pip/pip.conf
        echo "[global]" >> /root/.pip/pip.conf
        echo "index-url = http://pypi.douban.com/simple/" >> /root/.pip/pip.conf
        echo "<==========>更改源为豆瓣源<==========>"
        ;;
    *)
        echo "please Correct parameters"
        echo 'aliyun | qinghua | kejidaxue | douban'
        exit 1
esac