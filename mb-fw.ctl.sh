#!/bin/sh
#Linux iptables 
#mb-fw-ctl.sh
version='2.0.2';
buildDate='2015-04-02';
#LastUpdated by Perry: 2015-12-20


export PATH=/sbin:/bin:/usr/sbin:/usr/bin

#########################################
# 是否允许ping
# 
#########################################
ENABLE_PING='NO'


#########################################
# TCP公共开放端口
# 在这里指定的端口，将无条件允许通过防火墙
# 需要指定IP访问的端口，切勿设置在这里
# 以空格分隔多个端口
EXT_INPUT_TCP_PORTS='10050'

#9999:65535 is for passvie ftp


#########################################
# 指定TCP访问IP地址及端口
# 格式: 
# 1. 一个端口 IP-Port 如: 123.345.567.789/32-199
# 2. 一段端口 IP-Port:Port 如: 123.345.567.789/32-199:200
# 以空格分隔多个IP

#EXT_INPUT_TCP_HOSTS='192.168.0.5/32-22 192.168.3.4/32-3306 192.168.2.9/32-3306 192.168.2.6/32-3306 192.168.0.4/32-22 192.168.2.11/32-3306 192.168.0.5/32-3306 192.168.3.6/32-3306 192.168.2.10/32-3306 192.168.0.4/32-3306 192.168.3.8/32-22 192.168.3.6/32-22 192.168.2.4/32-3306 192.168.2.4/32-1521 192.168.2.5/32-3306 192.168.2.5/32-1521 192.168.2.7/32-3306 192.168.2.7/32-1521 192.168.2.8/32-3306 192.168.2.8/32-1521 192.168.2.9/32-1521 192.168.3.5/32-3306 192.168.3.5/32-1521 192.168.3.7/32-3306 192.168.3.7/32-1521';
#EXT_INPUT_TCP_HOSTS='172.17.20.176/16-13021 172.17.20.176/16-48669 172.17.20.176/16-52030 172.17.20.176/16-48671 172.17.20.176/16-10400 172.17.20.176/16-10401 172.17.20.176/16-58817 172.17.20.176/16-48673 0.0.0.0/16-58625 172.17.20.176/16-48674 172.17.20.176/16-48675 0.0.0.0/16-11300 172.17.20.176/16-10020 172.17.20.176/16-59173 172.17.20.176/16-13031 172.17.20.176/16-5000 172.17.20.176/16-48329';
EXT_INPUT_TCP_HOSTS='172.17.20.176/16-0:65535 172.17.20.211/16-0:65535 172.17.20.212/16-0:65535';

#########################################
# UDP公共开放端口
# 在这里指定的端口，将无条件允许通过防火墙
# 需要指定IP访问的端口，切勿设置在这里
# 以空格分隔多个IP
EXT_INPUT_UDP_PORTS='53 6000';


#########################################
# 指定TCP访问IP地址及端口
# 格式: 
# 1. 一个端口 IP-Port 如: 123.345.567.789/32-199
# 2. 一段端口 IP-Port:Port 如: 123.345.567.789/32-199:200
# 以空格分隔多个IP
EXT_INPUT_UDP_HOSTS='';
#53 for local dns server
#123 for local time server
#1194 6000 for openvpn
#514for remote logging


#########################################
# 完全禁止访问IP地址
# 在这里指定IP地址，将完全不能通过防火墙
# 格式: 123.345.567.789/32
# 以空格分隔多个IP
DROP_HOSTS=''


# 一些对外网卡的附加规则,将在上述TCP规则后附加此函数内规则
# 可以手工在这里增加TCP特殊规则
ext_input_addon_tcp_rules(){
  echo "ext_input_addon_tcp_rules";
	#for remote mysql
	#$IPT -A input-tcp -p tcp -s 123.345.567.789/32 --dport 3306 -j ACCEPT
	
	#for pptp server
	#$IPT -A input-tcp -p tcp --dport 1723 -j ACCEPT
	#for pptp incoming
	#$IPT -A INPUT -p gre -j ACCEPT
	

}


#
# 
# 可以手工在这里增加UDP特殊规则
ext_input_addon_udp_rules(){
  echo "ext_input_addon_udp_rules";
	#for remote snmpd
	#$IPT -A input-udp -p udp -s 123.345.567.789/32 --dport 161 -j ACCEPT
	
}
#
##-----------for internal network cards----------------------------------------
#edited by perry 2007.5.25

INT_INPUT_TCP_PORTS='3306 1521';

INT_INPUT_TCP_HOSTS='';

INT_INPUT_UDP_PORTS='';

INT_INPUT_UDP_HOSTS='';

INT_DROP_HOSTS='';





##----------------------------------------------------------------------------
#########

#
EXT_INPUT_RULES_ENABLE='YES'
INT_INPUT_RULES_ENABLE='NO'
FORWARD_RULES_ENABLE='NO'
NAT_RULES_ENABLE='NO'
EXT_HOOK_ENABLE='NO'
#

## rules base define
#another define
#YOU MUST SET INT_NIC FIRST
#INT_NIC="lo"
INT_NIC="eth0"

#EXT_NIC="AUTO"
EXT_NIC="etho"
EXT_ADDR="AUTO"
DEF_GATEWAY="AUTO"
EXT_AUTO="auto"

DMZ_NIC=""
DMZ_ADDR=""

#LOOPBACK="127.0.0.0/8" 
P_CLASS_A="10.0.0.0/8" 
P_CLASS_B="172.16.0.0/12" 
#P_CLASS_C="192.168.0.0/16" 
#P_CLASS_C=""
P_CLASS_D_MULTICAST="224.0.0.0/4" 
P_CLASS_E_RESERVED_NET="240.0.0.0/5" 
P_PORTS="0:1023" 
UP_PORTS="1024:65535" 
TR_SRC_PORTS="32769:65535" 
TR_DEST_PORTS="33434:33523" 

BROADCAST='255.255.255.255'

#echo "`date` Netfilter VAR:"
#echo "DEF_GATEWAY=$DEF_GATEWAY"
#echo "EXT_NIC=$EXT_NIC"
#echo "EXT_ADDR=$EXT_ADDR"
#echo "INT_NIC=$INT_NIC"
#echo "INT_ADDR=$INT_ADDR"

#

SQUIDPORT=6080

#

HOOK_PREFIX="iptables_hook"


IPT="/usr/sbin/iptables"

#end of init

#########################################################################
#########################################################################
#########################################################################
#########################################################################

initial_env(){
#base define
if [ ! -x $IPT ]
then
        echo "ERROR: $IPT is not executable."
        exit 1
fi

if [ "$1" = "-v" -o "$2" = "-v" ]
then
        IPT="$IPT -v"
fi
##========== 

if [ "$INT_NIC" = "NONE" ]
then
	echo "ERROR: !!! YOU MUST SET INT_NIC FIRST !!!"
	sleep 1
	exit 1
fi

INT_ADDR=`ifconfig $INT_NIC |grep 'inet addr' | awk '{ print $2 }' | awk -F: '{ print $2 }'`
if [ -z $INT_ADDR ]
then
        echo "Warning:Probe internal address fail.set to 127.0.0.1."
	sleep 3
	INT_ADDR="127.0.0.1"
	INT_NIC="lo"
fi

echo "setup sysctl ......"
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv4.tcp_syncookies=1
sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1 
echo '81920000' > /proc/sys/net/ipv4/ip_conntrack_max
sysctl -w net.ipv4.tcp_max_syn_backlog=81920
sysctl -w net.ipv4.netfilter.ip_conntrack_tcp_timeout_syn_recv=3 
sysctl -w net.ipv4.tcp_fin_timeout=30 
#sysctl -w net.ipv4.tcp_keepalive_time=7200
sysctl -w net.ipv4.tcp_keepalive_time=300
sysctl -w net.ipv4.tcp_window_scaling=1


echo "Load netfilter modules ......"
#iptables modules
#modprobe ip_tables
#nat
modprobe iptable_nat
#connect_track
modprobe ip_conntrack

#ftp NAT,PASV,PORT command.
#modprobe ip_conntrack_ftp
#modprobe ip_nat_ftp

#h323 NAT
#modprobe ip_conntrack_h323
#modprobe ip_nat_h323

#MSN talk
#modprobe ip_conntrack_talk
#modprobe ip_nat_talk
#pptp
#modprobe ip_conntrack_pptp
#modprobe ip_nat_pptp
#modprobe ip_conntrack_proto_gre
#modprobe ip_nat_proto_gre
#tftp
#modprobe ip_conntrack_tftp
#modprobe ip_nat_tftp

echo "Info:If something wrong in modprobe,don't panic,maybe you do not need that module."

## =================================================

#Auto probe EXT_NIC EXT_ADDR DEF_GATEWAY
echo "Probe default gateway  ......"
case ${EXT_AUTO} in
        [Aa][Uu][Tt][Oo])
                GW_COUNT=`netstat -arn | grep -c "^0.0.0.0\>"`
                if [ $GW_COUNT -gt 1 ]
                then
                        echo "Warnning,Multi default gateway found,use the first one."
                fi
                EXT_NIC=`netstat -arn | grep "^0.0.0.0\>" | awk '{print $8 }'`
                EXT_NIC=`echo $EXT_NIC | awk '{ print $1 }'`
                DEF_GATEWAY=`netstat -arn | grep "^0.0.0.0\>" | awk '{print $2 }'`
                DEF_GATEWAY=`echo $DEF_GATEWAY | awk '{ print $1 }'`
                if [ -z $EXT_NIC ]
                then
                        echo "ERROR EXT_NIC no found !!!"
                        exit 1
                else
                        export EXT_NIC DEF_GATEWAY
                        #get dynamic nic and ip.
                        EXT_ADDR=`ifconfig $EXT_NIC | grep 'inet\>' | awk '{print $2}'|awk -F: '{ print $2 }'`
                        if [ -z $EXT_ADDR ]
                        then
                                echo "ERROR EXT_ADDR no found!!!"
                                exit 1
                        else
                                export EXT_ADDR
                        fi
                fi
;;
        *)
        #User define
        EXT_NIC="eth1"
        EXT_ADDR="you-static-ip"
        DEF_GATEWAY="you-gw"
;;
esac
}

copyleft()
{
echo "."
echo "Netfilter configure scripts version $version [ $buildDate ],by adrianyang.blog.isyi.com."
uname -a
echo "."
sleep 1
}

setmac(){
#
#setup MAC
#ed0: flags=8843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST> mtu 1500
#        inet you-static-ip netmask 0xfffffff0 broadcast 211.97.116.223
#        ether 00:00:25:03:82:99
#ifconfig $EXT_NIC hw ether 00:00:25:03:82:98
#real 99
ifconfig $EXT_NIC hw ether 00:00:25:03:82:99
if [ $? -ne 0 ]
then
	echo "Error:Set MAC for $EXT_NIC fail."
	exit 1
fi
}
#============================================================================================

reset_netfilter()
{
#
# reset the default policies in the filter table.
$IPT -P INPUT ACCEPT

$IPT -P FORWARD ACCEPT
$IPT -P OUTPUT ACCEPT

#
# reset the default policies in the nat table.
#
$IPT -t nat -P PREROUTING ACCEPT
$IPT -t nat -P POSTROUTING ACCEPT
$IPT -t nat -P OUTPUT ACCEPT

#
# reset the default policies in the mangle table.
#
$IPT -t mangle -P PREROUTING ACCEPT
$IPT -t mangle -P OUTPUT ACCEPT

#
# flush all the rules in the filter and nat tables.
#
$IPT -F
$IPT -t nat -F
$IPT -t mangle -F
#
# erase all chains that's not default in filter and nat table.
#
$IPT -X
$IPT -t nat -X
$IPT -t mangle -X

#Zero counters in all chains
$IPT -Z
$IPT -t nat -Z
$IPT -t mangle -Z
}
#================================================================================================
internal_input_rules(){
#
#global INPUT rules
#for ESTABLISHED,RELATED packets
$IPT -A INPUT -i $INT_NIC -m state --state ESTABLISHED,RELATED -j ACCEPT
#

#hard drop
#$IPT -A INPUT  -i $INT_NIC -s 222.84.147.0/24 -j DROP

# Refuse broadcast address packets. 
#
$IPT -A INPUT -i $INT_NIC -p udp -d $BROADCAST -j DROP

##
# 完全禁止IP
# 2006-6-23
for dropHost_int in $INT_DROP_HOSTS
do
	test -z "$dropHost_int" && continue
  $IPT -A INPUT  -i $INT_NIC -s $dropHost_int -j DROP
	if [ $? -ne 0 ]
	then
		echo "Error:Setup drop rules for host[${dropHost_int}] fail."
	fi
done

#tcp input rules

#tcp input rules
$IPT -N input-tcp-int
$IPT -N input-flood-tcp-int
$IPT -A INPUT -i $INT_NIC -p tcp -j input-tcp-int
#
## Make sure NEW tcp connections are SYN packets 
$IPT -A input-tcp-int -p tcp ! --syn -m state --state NEW -j DROP 
#
$IPT -A input-tcp-int -j input-flood-tcp-int
#
$IPT -A input-flood-tcp-int -m limit --limit 700/s --limit-burst 900 -j RETURN
$IPT -A input-flood-tcp-int -j DROP 

###input ports
for portenrty_int in $INT_INPUT_TCP_PORTS
do
	test -z "$portenrty_int" && continue
	$IPT -A input-tcp-int -p tcp --dport $portenrty_int -j ACCEPT
	if [ $? -ne 0 ]
	then
		echo "Error:Setup tcp rules for port $portenrty_int fail."
	fi
done
##

# 开放指定IP及端口
# 2006-6-23
for tcpHostPort_int in $INT_INPUT_TCP_HOSTS
do
	test -z "$tcpHostPort_int" && continue
  #取得主机IP地址
  tcpHost_int=`echo "${tcpHostPort_int}" |awk -F\- '{print $1}'`;
  #取得开放端口
  tcpPort_int=`echo "${tcpHostPort_int}" |awk -F\- '{print $2}'`;
	$IPT -A input-tcp-int -s $tcpHost_int -p tcp --dport $tcpPort_int -j ACCEPT
	if [ $? -ne 0 ]
	then
		echo "Error:Setup firewall rules for host[${tcpHost_int}] port[${tcpPort_int}] fail."
	fi
done


## AUTH server 
# Reject ident probes with a tcp reset. 
# I need to do this for a broken mailhost that won't accept my mail if I just drop its ident probe. 
$IPT -A input-tcp-int -p tcp --dport 113 -j REJECT --reject-with tcp-reset 
	
#another tcp DROP
$IPT -A input-tcp-int -j DROP
#end of tcp input

#udp input rules
$IPT -N input-udp-int
$IPT -N input-flood-udp-int
$IPT -A INPUT -i $INT_NIC -p udp -j input-udp-int
####################################

#
$IPT -A input-udp-int -j input-flood-udp-int
#
$IPT -A input-flood-udp-int -m limit --limit 500/s --limit-burst 800 -j RETURN
$IPT -A input-flood-udp-int -j DROP 

#another udp rules
###input ports
# 开放不指定访问IP的UDP端口
for portenrty_int in $INT_INPUT_UDP_PORTS
do
	test -z "$portenrty_int" && continue
	$IPT -A input-udp-int -p udp --dport $portenrty_int -j ACCEPT
	if [ $? -ne 0 ]
	then
		echo "Error:Setup udp rules for port $portenrty_int fail."
	fi
done


###
# 开放指定访问IP的UDP端口
# 2006-6-23
for udpHostPort_int in $INT_INPUT_UDP_HOSTS
do
	test -z "$udpHostPort_int" && continue
  #取得主机IP地址
  udpHost_int=`echo "${udpHostPort_int}" |awk -F\- '{print $1}'`;
  #取得开放端口
  udpPort_int=`echo "${udpHostPort_int}" |awk -F\- '{print $2}'`;
	$IPT -A input-udp-int -p udp -s $udpHost_int --dport $udpPort_int -j ACCEPT
	if [ $? -ne 0 ]
	then
		echo "Error:Setup udp rules for host[${udpHost_int}] port[${udpPort_int}] fail."
	fi
done


#call
#int_input_addon_udp_rules

$IPT -A input-udp-int -j DROP
#end of INPUT

#icmp input rules
$IPT -N input-icmp-int
$IPT -N input-flood-icmp-int
$IPT -A INPUT -i $INT_NIC -p icmp -j input-icmp-int

#input-icmp rules
$IPT -A input-icmp-int -j input-flood-icmp-int
#another icmp rules

#input-flood-icmp rules

$IPT -A input-flood-icmp-int -m limit --limit 500/s --limit-burst 800 -j RETURN
$IPT -A input-flood-icmp-int -j DROP 
#end of input-flood-icmp-int rules

#enable ping
if [ "${ENABLE_PING}" = "YES" ]; then
$IPT -A input-icmp-int -p icmp --icmp-type echo-request -j ACCEPT
fi
# ICMP 

#another DROP
$IPT -A input-icmp-int -j DROP
#end of input-icmp

#INVALID DROP
$IPT -A INPUT -i $INT_NIC -m state --state INVALID -j DROP
#end of global input rules

#another DROP
#$IPT -A INPUT -i $INT_NIC -j DROP
#end of internal_input_rules
}


## ===============================================================================================
external_input_rules()
{
#
#global INPUT rules
#for ESTABLISHED,RELATED packets
$IPT -A INPUT -i $EXT_NIC -m state --state ESTABLISHED,RELATED -j ACCEPT
#

#hard drop
#$IPT -A INPUT  -i $EXT_NIC -s 222.84.147.0/24 -j DROP

#
# Refuse spoofed packets pretending to be from your IP address. 
#$IPT -A INPUT  -i $EXT_NIC -s $EXT_ADDR -j DROP
# Refuse packets claiming to be from a Class A private network. 
$IPT -A INPUT  -i $EXT_NIC -s $P_CLASS_A -j DROP 
# Refuse packets claiming to be from a Class B private network. 
$IPT -A INPUT  -i $EXT_NIC -s $P_CLASS_B -j DROP 
# Refuse packets claiming to be from a Class C private network. 
#$IPT -A INPUT  -i $EXT_NIC -s $P_CLASS_C -j DROP 
# Refuse Class D multicast addresses. Multicast is illegal as a source address. 
$IPT -A INPUT -i $EXT_NIC -s $P_CLASS_D_MULTICAST -j DROP 
# Refuse Class E reserved IP addresses. 
$IPT -A INPUT -i $EXT_NIC -s $P_CLASS_E_RESERVED_NET -j DROP 
#
#$IPT -A INPUT -i $EXT_NIC -d $LOOPBACK -j DROP

# Refuse broadcast address packets. 
#
$IPT -A INPUT -i $EXT_NIC -p udp -d $BROADCAST -j DROP


##
# 完全禁止IP
# 2006-6-23
for dropHost in $DROP_HOSTS
do
	test -z "$dropHost" && continue
  $IPT -A INPUT  -i $EXT_NIC -s $dropHost -j DROP
	if [ $? -ne 0 ]
	then
		echo "Error:Setup drop rules for host[${dropHost}] fail."
	fi
done

#####################################

## INPUT SYN-FLOODING PROTECTION 

#RETURN is continue check rules.

#pre drop address

#$IPT -A INPUT -i $EXT_NIC -s 218.19.69.34 -j DROP

#Ip FRAGMENTS limit
$IPT -A INPUT -f -m limit --limit 500/s --limit-burst 600 -j ACCEPT
#

#tcp input rules

#tcp input rules
$IPT -N input-tcp
$IPT -N input-flood-tcp
$IPT -A INPUT -i $EXT_NIC -p tcp -j input-tcp
#
## Make sure NEW tcp connections are SYN packets 
$IPT -A input-tcp -p tcp ! --syn -m state --state NEW -j DROP 
#
$IPT -A input-tcp -j input-flood-tcp
#
$IPT -A input-flood-tcp -m limit --limit 700/s --limit-burst 900 -j RETURN
$IPT -A input-flood-tcp -j DROP 

###input ports
for portenrty in $EXT_INPUT_TCP_PORTS
do
	test -z "$portenrty" && continue
	$IPT -A input-tcp -p tcp --dport $portenrty -j ACCEPT
	if [ $? -ne 0 ]
	then
		echo "Error:Setup tcp rules for port $portenrty fail."
	fi
done

#call
ext_input_addon_tcp_rules


##
# 开放指定IP及端口
# 2006-6-23
for tcpHostPort in $EXT_INPUT_TCP_HOSTS
do
	test -z "$tcpHostPort" && continue
  #取得主机IP地址
  tcpHost=`echo "${tcpHostPort}" |awk -F\- '{print $1}'`;
  #取得开放端口
  tcpPort=`echo "${tcpHostPort}" |awk -F\- '{print $2}'`;
	$IPT -A input-tcp -s $tcpHost -p tcp --dport $tcpPort -j ACCEPT
	if [ $? -ne 0 ]
	then
		echo "Error:Setup firewall rules for host[${tcpHost}] port[${tcpPort}] fail."
	fi
done


## AUTH server 
# Reject ident probes with a tcp reset. 
# I need to do this for a broken mailhost that won't accept my mail if I just drop its ident probe. 
$IPT -A input-tcp -p tcp --dport 113 -j REJECT --reject-with tcp-reset 
	
#another tcp DROP
$IPT -A input-tcp -j DROP
#end of tcp input

#udp input rules
$IPT -N input-udp
$IPT -N input-flood-udp
$IPT -A INPUT -i $EXT_NIC -p udp -j input-udp
####################################

#
$IPT -A input-udp -j input-flood-udp
#
$IPT -A input-flood-udp -m limit --limit 500/s --limit-burst 800 -j RETURN
$IPT -A input-flood-udp -j DROP 

#another udp rules
###input ports
# 开放不指定访问IP的UDP端口
for portenrty in $EXT_INPUT_UDP_PORTS
do
	test -z "$portenrty" && continue
	$IPT -A input-udp -p udp --dport $portenrty -j ACCEPT
	if [ $? -ne 0 ]
	then
		echo "Error:Setup udp rules for port $portenrty fail."
	fi
done


###
# 开放指定访问IP的UDP端口
# 2006-6-23
for udpHostPort in $EXT_INPUT_UDP_HOSTS
do
	test -z "$udpHostPort" && continue
  #取得主机IP地址
  udpHost=`echo "${udpHostPort}" |awk -F\- '{print $1}'`;
  #取得开放端口
  udpPort=`echo "${udpHostPort}" |awk -F\- '{print $2}'`;
	$IPT -A input-udp -p udp -s $udpHost --dport $udpPort -j ACCEPT
	if [ $? -ne 0 ]
	then
		echo "Error:Setup udp rules for host[${udpHost}] port[${udpPort}] fail."
	fi
done


#call
ext_input_addon_udp_rules

$IPT -A input-udp -j DROP
#end of INPUT

#icmp input rules
$IPT -N input-icmp
$IPT -N input-flood-icmp
$IPT -A INPUT -i $EXT_NIC -p icmp -j input-icmp

#input-icmp rules
$IPT -A input-icmp -j input-flood-icmp
#another icmp rules

#input-flood-icmp rules

$IPT -A input-flood-icmp -m limit --limit 500/s --limit-burst 800 -j RETURN
$IPT -A input-flood-icmp -j DROP 
#end of input-flood-icmp rules

#enable ping
if [ "${ENABLE_PING}" = "YES" ]; then
$IPT -A input-icmp -p icmp --icmp-type echo-request -j ACCEPT
fi
# ICMP 

#another DROP
$IPT -A input-icmp -j DROP
#end of input-icmp

#INVALID DROP
$IPT -A INPUT -i $EXT_NIC -m state --state INVALID -j DROP
#end of global input rules
}
## ============================================================================================================

## ==========
forward_rules(){
#
#global FORWARD rules
#for ESTABLISHED,RELATED packets
$IPT -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
#

#hard drop
#$IPT -A FORWARD -s 222.84.147.0/24 -j DROP

#for vpn
$IPT -A FORWARD -s 10.101.0.0/16 -j ACCEPT


#another DROP
$IPT -A FORWARD -j DROP
#end of forward_rules
}
## ==========

## ============================================================================================================
nat_rules()
{
#global NAT rules

#INCOMING DNAT rules

#for h232 connect in.
#$IPT -t nat -A PREROUTING -i $EXT_NIC -p tcp -m tcp --dport 1720 -j DNAT --to $H323_ADDR:1720
#for apache server connect in.
#$IPT -t nat -A PREROUTING -i $EXT_NIC -p tcp -m tcp -d $EXT_ADDR --dport 80 -j DNAT --to $WEBSERVER_ADDR:80

#for 3proxy
#$IPT -t nat -A PREROUTING -i $EXT_NIC -p tcp -m tcp -d $EXT_ADDR --dport 1580 -j DNAT --to 172.16.188.100:80

$IPT -t nat -A POSTROUTING -o $EXT_NIC -j MASQUERADE


#$IPT -t nat -A POSTROUTING -o $EXT_NIC -p tcp -j SNAT --to-source $EXT_ADDR:10000-50000
#$IPT -t nat -A POSTROUTING -o $EXT_NIC -p udp -j SNAT --to-source $EXT_ADDR:10000-50000
#$IPT -t nat -A POSTROUTING -o $EXT_NIC -s 172.16.100.0/16 -j SNAT --to-source $EXT_ADDR
#echo 'Empty nat rules.'
#end of global NAT rules
}
## ==============================================================================================================

default_netfilter()
{
#
# reset the default policies in the filter table.

$IPT -P INPUT ACCEPT
$IPT -P FORWARD ACCEPT
$IPT -P OUTPUT ACCEPT

#
# reset the default policies in the nat table.
#
$IPT -t nat -P PREROUTING ACCEPT
$IPT -t nat -P POSTROUTING ACCEPT
$IPT -t nat -P OUTPUT ACCEPT

#
# reset the default policies in the mangle table.
#
$IPT -t mangle -P PREROUTING ACCEPT
$IPT -t mangle -P OUTPUT ACCEPT

## LOOPBACK 
# Allow unlimited traffic on the loopback interface. 
$IPT -A INPUT  -i lo -j ACCEPT 
$IPT -A OUTPUT -o lo -j ACCEPT 

## INTERNAL NIC
# Allow unlimited traffic on the INTERNAL interface. 
$IPT -A INPUT  -i $INT_NIC -j ACCEPT 
$IPT -A OUTPUT -o $INT_NIC -j ACCEPT 

}

## =====

## =========================================================== 
########### ext pro hook
ext_hooks(){
if [ $# -ne 1 ] 
then
	echo "Error:Arg number for ext_hooks is not 1 ."
	return 1
fi

ext_arg=$1

hooks_stat=0
hookcount=1
while [ : ]
do
	eval ext_prog=\$"${HOOK_PREFIX}_$hookcount"
	if [ -z "${ext_prog}" ]
	then
		break
	fi
	echo "Info:Call ${ext_prog} ${HOOK_PREFIX}_${ext_arg} ..."
	${ext_prog} ${HOOK_PREFIX}_${ext_arg}
	extreturn=$?
	hooks_stat=`expr $hooks_stat + $extreturn `
	if [ $extreturn -ne 0 ]
	then
		echo "Warning:Call ${ext_prog} ${ext_arg} return code=$extreturn."
	fi
	hookcount=`expr $hookcount + 1 `
done

return $hooks_stat

}

## =========================================================== 








############## MAIN from here########################

#for fun
copyleft

initial_env

if [ "$1" = "reset" ]
then
	#call reset
	reset_netfilter	
	echo "Iptables reseted."
	exit 0
fi

if [ "$1" = "stop" ]
then
	#call reset
	
	#reset_netfilter	
	echo "Iptables stopped."
	#call ext hooks
	ext_hooks stop
	exit $?
fi

#all other is start
#setMAC
#setmac

echo "Load iptables rules ......"
###########################################


#call reset iptables;
reset_netfilter

#call input rules
test "$EXT_INPUT_RULES_ENABLE" = 'YES' && external_input_rules

#call
test "$INT_INPUT_RULES_ENABLE" = 'YES' && internal_input_rules

#call forward rules
test "$FORWARD_RULES_ENABLE" = 'YES' && forward_rules


#call nat rules
test "$NAT_RULES_ENABLE" = 'YES' && nat_rules

#call ext hooks
test "$EXT_HOOK_ENABLE" = 'YES' && ext_hooks start

#call default iptables;
default_netfilter

if [ "$1" = "-v" -o "$2" = "-v" ]
then
	#
	#list rules
	$IPT -L -n -v
	#list nat rules
	$IPT -t nat -L -n -v
fi

echo "`date` Info:netfilter configure done."
#end of start
#end of ipt
