#!/bin/bash
read -t 10 -p "password: " passwd
echo "<=============>install package.........<================>"
yum install -y openldap openldap-clients openldap-servers >> /dev/null 2>&1
LDAP_PASSWORD=$(slappasswd -s $passwd)
Ldap_Profile () {
    systemctl stop firewalld &&  systemctl disable firewalld >> /dev/null 2>&1
    setenforce 0 && sed -i "s/SELINUX=enforing/SELINUX=disabled/g" /etc/selinux/config
    cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
    chown -R ldap. /var/lib/ldap/DB_CONFIG
    systemctl start slapd
    systemctl enable slapd >> /dev/null 2>&1
}


cat <<EOF >/root/changepwd.ldif
dn: olcDatabase={0}config,cn=config
changetype: modify
add: olcRootPW
olcRootPW: $LDAP_PASSWORD
EOF



cat <<EOF >/root/changedomain.ldif
dn: olcDatabase={1}monitor,cn=config
changetype: modify
replace: olcAccess
olcAccess: {0}to * by dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth" read by dn.base="cn=admin,dc=yaobili,dc=com" read by * none

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: dc=yaobili,dc=com

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=admin,dc=yaobili,dc=com

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcRootPW
olcRootPW: $LDAP_PASSWORD

dn: olcDatabase={2}hdb,cn=config
changetype: modify
add: olcAccess
olcAccess: {0}to attrs=userPassword,shadowLastChange by dn="cn=admin,dc=yaobili,dc=com" write by anonymous auth by self write by * none
olcAccess: {1}to dn.base="" by * read
olcAccess: {2}to * by dn="cn=admin,dc=yaobili,dc=com" write by * read
EOF


cat <<EOF > /root/base.ldif
dn: dc=yaobili,dc=com
objectClass: top
objectClass: dcObject
objectClass: organization
o: Yaobili Company
dc: yaobili

dn: cn=admin,dc=yaobili,dc=com
objectClass: organizationalRole
cn: admin

dn: ou=People,dc=yaobili,dc=com
objectClass: organizationalUnit
ou: People

dn: ou=Group,dc=yaobili,dc=com
objectClass: organizationalRole
cn: Group
EOF


LDAP_Schema () {
    echo "<=============>ipmort config<==============>"
    cd /root
    ldapadd -Y EXTERNAL -H ldapi:/// -f changepwd.ldif >> /dev/null  2>&1
    ldapmodify -Y EXTERNAL -H ldapi:/// -f changedomain.ldif >> /dev/bull 2>&1
    echo "<=============>import schema.......<================>"
    ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif >> /dev/null 2>&1
    ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif >> /dev/null 2>&1
    ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif >> /dev/null 2>&1
    ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/collective.ldif >> /dev/null 2>&1
    ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/corba.ldif >> /dev/null 2>&1
    ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/duaconf.ldif >> /dev/null 2>&1
    ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/dyngroup.ldif >> /dev/null 2>&1
    ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/java.ldif >> /dev/null 2>&1
    ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/misc.ldif >> /dev/null 2>&1
    ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/openldap.ldif >> /dev/null 2>&1
    ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/pmi.ldif >> /dev/null 2>&1
    ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/ppolicy.ldif >> /dev/null 2>&1
    echo 'please implement cmd ldapadd -x -D cn=admin,dc=yaobili,dc=com -W -f base.ldif'
}
Ldap_Profile
LDAP_Schema
cat <<EOF
如果以上没有报错，那么就已经完成ldap搭建
base:dc=yaobili,dc=admin,dc=com
user:cn=admin,dc=yaobili,dc=com
password:$passwd
EOF