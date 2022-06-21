#!/bib/bash
#直连agent ,中控
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.212 -p tcp --dport 2181 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.176 -p tcp --dport 48533 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.176 -p tcp --dport 58625 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.176 -p tcp --dport 59173 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.176 -p tcp --dport 10020 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.176 -p udp --dport 10020 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.176 -p udp --dport 10030 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.176 -p udp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.176 -p tcp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.176 -p tcp --dport 58930 -j ACCEPT

#直连agent，211
iptables -I INPUT -s 172.17.20.211 -d 172.17.20.212 -p tcp --dport 2181 -j ACCEPT
iptables -I INPUT -s 172.17.20.211 -d 172.17.20.176 -p tcp --dport 48533 -j ACCEPT
iptables -I INPUT -s 172.17.20.211 -d 172.17.20.176 -p tcp --dport 58625 -j ACCEPT
iptables -I INPUT -s 172.17.20.211 -d 172.17.20.176 -p tcp --dport 59173 -j ACCEPT
iptables -I INPUT -s 172.17.20.211 -d 172.17.20.176 -p tcp --dport 10020 -j ACCEPT
iptables -I INPUT -s 172.17.20.211 -d 172.17.20.176 -p udp --dport 10020 -j ACCEPT
iptables -I INPUT -s 172.17.20.211 -d 172.17.20.176 -p udp --dport 10030 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.211 -p udp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.211 -p tcp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.176 -p tcp --dport 58930 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.176 -p tcp --dport 10020 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.176 -p udp --dport 10020 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.176 -p udp --dport 10030 -j ACCEPT
iptables -I INPUT -s 172.17.20.211 -d 172.17.20.211 -p tcp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -s 172.17.20.211 -d 172.17.20.211 -p udp --dport 60020:60030 -j ACCEPT


#直连agent，212
iptables -I INPUT -s 172.17.20.212 -d 172.17.20.212 -p tcp --dport 2181 -j ACCEPT
iptables -I INPUT -s 172.17.20.212 -d 172.17.20.176 -p tcp --dport 48533 -j ACCEPT
iptables -I INPUT -s 172.17.20.212 -d 172.17.20.176 -p tcp --dport 58625 -j ACCEPT
iptables -I INPUT -s 172.17.20.212 -d 172.17.20.176 -p tcp --dport 59173 -j ACCEPT
iptables -I INPUT -s 172.17.20.212 -d 172.17.20.176 -p tcp --dport 10020 -j ACCEPT
iptables -I INPUT -s 172.17.20.212 -d 172.17.20.176 -p udp --dport 10020 -j ACCEPT
iptables -I INPUT -s 172.17.20.212 -d 172.17.20.176 -p udp --dport 10030 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.212 -p udp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.212 -p tcp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.176 -p tcp --dport 58930 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.176 -p tcp --dport 10020 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.176 -p udp --dport 10020 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d 172.17.20.176 -p udp --dport 10030 -j ACCEPT
iptables -I INPUT -s 172.17.20.212 -d 172.17.20.212 -p tcp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -s 172.17.20.212 -d 172.17.20.212 -p udp --dport 60020:60030 -j ACCEPT


#ip互访 172.17.20.176
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
iptables -I INPUT -p tcp --dport 48533 -j ACCEPT
iptables -I INPUT -p tcp --dport 58625 -j ACCEPT
iptables -I INPUT -p tcp --dport 59173 -j ACCEPT
iptables -I INPUT -p tcp --dport 10020 -j ACCEPT
iptables -I INPUT -p udp --dport 10020 -j ACCEPT
iptables -I INPUT -p udp --dport 10030 -j ACCEPT
iptables -I INPUT -p tcp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -p udp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -p tcp --dport 58930 -j ACCEPT
iptables -I INPUT -s 172.17.20.211 -p tcp -j ACCEPT
iptables -I INPUT -s 172.17.20.212 -p tcp -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -p tcp -j ACCEPT
iptables -I INPUT -s 127.0.0.1 -p tcp -j ACCEPT
iptables -A INPUT -p tcp -j DROP
#ip互访 172.17.20.211
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
iptables -I INPUT -s 172.17.20.211 -p tcp -j ACCEPT
iptables -I INPUT -s 172.17.20.212 -p tcp -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -p tcp -j ACCEPT
iptables -I INPUT -s 127.0.0.1 -p tcp -j ACCEPT
iptables -A INPUT -p tcp -j DROP
#ip互访 172.17.20.212
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
iptables -I INPUT -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -p tcp --dport 2181 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -p tcp -j ACCEPT
iptables -I INPUT -s 172.17.20.211 -p tcp -j ACCEPT
iptables -I INPUT -s 172.17.20.212 -p tcp -j ACCEPT
iptables -I INPUT -s 127.0.0.1 -p tcp -j ACCEPT
iptables -A INPUT -p tcp -j DROP

#ip互访 10.10.9.30
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
iptables -I INPUT -p tcp --dport 48533 -j ACCEPT
iptables -I INPUT -p tcp --dport 58625 -j ACCEPT
iptables -I INPUT -p tcp --dport 59173 -j ACCEPT
iptables -I INPUT -p tcp --dport 10020 -j ACCEPT
iptables -I INPUT -p udp --dport 10020 -j ACCEPT
iptables -I INPUT -p udp --dport 10030 -j ACCEPT
iptables -I INPUT -p tcp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -p udp --dport 60020:60030 -j ACCEPT
iptables -I INPUT -p tcp --dport 58930 -j ACCEPT
iptables -I INPUT -s 10.10.9.30 -p tcp -j ACCEPT
iptables -I INPUT -s 10.10.9.31 -p tcp -j ACCEPT
iptables -I INPUT -s 10.10.9.32 -p tcp -j ACCEPT
iptables -I INPUT -s 127.0.0.1 -p tcp -j ACCEPT
iptables -A INPUT -p tcp -j DROP
#ip互访 10.10.9.31
iptables -I INPUT -s 10.10.9.30 -p tcp -j ACCEPT
iptables -I INPUT -s 10.10.9.31 -p tcp -j ACCEPT
iptables -I INPUT -s 10.10.9.32 -p tcp -j ACCEPT
iptables -I INPUT -s 127.0.0.1 -p tcp -j ACCEPT
iptables -A INPUT -p tcp -j DROP
#ip互访 10.10.9.32
iptables -I INPUT -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -p tcp --dport 2181 -j ACCEPT
iptables -I INPUT -s 10.10.9.30 -p tcp -j ACCEPT
iptables -I INPUT -s 10.10.9.31 -p tcp -j ACCEPT
iptables -I INPUT -s 10.10.9.32 -p tcp -j ACCEPT
iptables -I INPUT -s 127.0.0.1 -p tcp -j ACCEPT
iptables -A INPUT -p tcp -j DROP
















#proxy-gse
iptables -I INPUT -s $PROXY -d 172.17.20.176 -p tcp --dport 48533 -j ACCEPT
iptables -I INPUT -s $PROXY -d 172.17.20.176 -p tcp --dport 58625 -j ACCEPT
iptables -I INPUT -s $PROXY -d 172.17.20.176 -p tcp --dport 58930 -j ACCEPT
iptables -I INPUT -s $PROXY -d 172.17.20.176 -p tcp --dport 10020 -j ACCEPT
iptables -I INPUT -s $PROXY -d 172.17.20.176 -p udp --dport 10020 -j ACCEPT
iptables -I INPUT -s $PROXY -d 172.17.20.176 -p udp --dport 10030 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d $PROXY -p tcp --dport 58930 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d $PROXY -p tcp --dport 10020 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d $PROXY -p udp --dport 10020 -j ACCEPT
iptables -I INPUT -s 172.17.20.176 -d $PROXY -p udp --dport 10030 -j ACCEPT


iptables -I INPUT -s $PROXY -d $PROXY -p tcp --dport 58930 -j ACCEPT
iptables -I INPUT -s $PROXY -d $PROXY -p tcp --dport 10020 -j ACCEPT
iptables -I INPUT -s $PROXY -d $PROXY -p udp --dport 10020 -j ACCEPT
iptables -I INPUT -s $PROXY -d $PROXY -p udp --dport 10030 -j ACCEPT
iptables -I INPUT -s $PROXY -d 172.17.20.176 -p tcp --dport 58725 -j ACCEPT