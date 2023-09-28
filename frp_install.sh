#!/bin/bash
cat << EOF
frp_pag变量改成frp包路径如/usr/local/src/
frp_version变量改为frp包名如frp_0.51.3_linux_386.tar.gz
若安装客户端请教WIP改为云主机公网地址
EOF
frp_pag=/tmp/frp_0.51.3_linux_386.tar.gz
########env########
Frp_Dir=/etc/frp/
Frp_Log_Dir=/var/log/frp
Frp_Bin=/usr/bin
Frp_Port=5600
Tmp_Dir=/usr/local/src/
WIP=

#######funntion#####

preparation () {
    if [ ! -z $frp_pag ] ;then
         export Frp_Name=$(echo $frp_pag | awk -F / '{print $3}' | sed "s#\.tar\.gz##g")
         tar -xf $frp_pag -C $Tmp_Dir
	 [ $? -ge 1 ] && exit 2
         [ -d $Frp_Dir ] || mkdir $Frp_Dir
	 [ -d $Frp_Log_Dir ] || mkdir $Frp_Log_Dir
    else
        echo "please Enter FRP package address or name"
        exit 2
    
    fi

}

Server_Config_Data () {

cat  <<  EOF  > $Frp_Dir/frps.ini
[common]
bind_port = $Frp_Port
token = actually
EOF

}

Client_Config_Data () {

cat  <<  EOF  > $Frp_Dir/frpc.ini
[common]
server_addr = $WIP
server_port = $Frp_Port
token = actually

[ssh]
remote_port = 10020
type = tcp
local_ip = 127.0.0.1
local_port = 22
EOF

}

Filewalld_Add () {
    local port=(22 $Frp_Port 10020 10021 80)
    if systemctl status firewalld ; then
        for i in ${port[*]}
        do
            firewall-cmd --add-port=$i/tcp --permanent
        done
        firewall-cmd --reload
    else
        systemctl restart firewalld
        for i in ${port[*]} ;do firewall-cmd --add-port={$i/tcp} --permanent ; done
        firewall-cmd --reload
    fi
}

Start_Services () {
    [ -x $Frp_Bin/$1 ] || cp $Tmp_Dir/$Frp_Name/$1 $Frp_Bin
    $Frp_Bin/$1 -c $Frp_Dir/$1.ini >> $Frp_Log_Dir/$1.log &
}

Stop_Services () {
    if [ $(ps -aux | grep -i $Frp_Bin/$1 | grep -v grep | wc -l) -eq 1 ] ;then

        ps -aux | grep -i $Frp_Bin/$1 | grep -v grep | awk '{print $2}' | xargs kill -9
        [ $(ss -tnulp | grep -i $Frp_Port | wc -l) -eq 0  ] && echo "process killed" || echo "port is running"

    else
        echo "FRP not running"
    fi

}

Restart_Service () {
    Stop_Sservice $1
    Start_Service $1
}

Server_Install () {
    preparation
    Server_Config_Data
    Filewalld_Add
    Start_Services frps       

}


Clinet_Install () {
    preparation
    Client_Config_Data
    Filewalld_Add
    Start_Servies frpc
}


main () {
    case $1 in
        server)
            case $2 in 
                install)
                    Server_Install
                ;;
                start)
                    Start_Services frps
                ;;
                stop)
                    Stop_Services frps
                ;;
                restart)
                    Restart_Service frps
                ;;
                *)
                    echo -e "\033[31merror please  input install or start or stop or restart\033[0m"
             ;;
             esac
        ;;
        client)
            case $2 in
                install)
                    Clinet_Install
                ;;
                start)
                    Start_Services frpc
                ;;
                stop)
                    Stop_Services frpc
                ;;
                restart)
                    Restart_Service frpc
                ;;      
                *)
                    echo -e "\033[31mError please  input install or start or stop or restart\033[0m"
            ;;
            esac
        ;;
        *)
            echo -e "\033[31merror please once again input\033[0m"
            exit 2
        ;;
     esac
}

main $*
