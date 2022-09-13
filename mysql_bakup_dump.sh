#!/bin/bash
MYSQL_PASSWD_="!QAZ2wsx"
MYSQL_BACKUP_DATA=/backup
for i in `mysql -uroot -p${MYSQL_PASSWD_} << EOF
show databases;
EOF
do
    mysqldump -uroot -p${MYSQL_PASSWD_} $i > /bakup/$i.sql
done
for i in $(ls $MYSQL_BACKUP_DATA | grep *.sql)
do
    mysqldump -uroot -p${MYSQL_PASSWD} < ${MYSQL_BACKUP_DATA}/$i
done



USAGE () {
    echo "xxxx.sh [agrs] \
    [args] --backup and -b or --import and -I
    "
}
case $1 in
    --backup | -b)
        for i in `mysql -uroot -p${MYSQL_PASSWD_} << EOF 
        show databases; 
        EOF`
        do
            mysqldump -uroot -p${MYSQL_PASSWD_} $i > /bakup/$i.sql
        done
        ;;
    --import | -I)
        for i in `ls $MYSQL_BACKUP_DATA | grep *.sql`
        do
            mysqldump -uroot -p${MYSQL_PASSWD} < ${MYSQL_BACKUP_DATA}/$i
        done
        ;;
        *)
            USAGE
esac


