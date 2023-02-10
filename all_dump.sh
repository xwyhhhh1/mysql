#!/bin/bash

### var

Mysql_Bin_Path=/usr/local/mysql/bin
Mysql_Dump_Path=/tmp
Dump_User=root
Dump_Password='!QAZ2wsx'
Socket_Path=/data/mysql/mysql.sock


#### function

all_dump () {
    ${Mysql_Bin_Path}/mysqldump -u${Dump_User} -p${Dump_Password} -S ${Socket_Path} -A -B -x --master-data=2 | gzip > ${Mysql_Dump_Path}/db_all_$(date +%F).gz
    md5sum ${Mysql_Dump_Path}/db_all_$(date +%F).gz > db_all_$(date +%F).md5
}
dump_databases(){
    ${Mysql_Bin_Path}/mysqldump -u${Dump_User} -p${Dump_Password} -S ${Socket_Path}  -e 'show databases;' | grep -vE '*_schema|Database' | sed -r 's#^(.*)#${Mysql_Bin_Path}/mysqldump \1 | gzip >${Mysql_Dump_Path}\1.sql.gz#g' | bash 
}


