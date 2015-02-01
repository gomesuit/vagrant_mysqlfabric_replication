#!/bin/sh

. /etc/global.rc

# install cmake ncurses
yum -y install cmake ncurses-devel

groupadd mysql
useradd -r -g mysql mysql

\rm -rf ${MYSQL_HOME}
\rm -rf ${SRC_HOME}/${MYSQL_SRC}

cd ${SRC_HOME}
wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.22.tar.gz
tar zxf ${MYSQL_SRC}.tar.gz
cd ${MYSQL_SRC}
cmake . -DCMAKE_INSTALL_PREFIX=${MYSQL_HOME} -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci
make
make install
cd ${MYSQL_HOME}
chown -R mysql .
chgrp -R mysql .
scripts/mysql_install_db --datadir=${MYSQL_HOME}/data --user=mysql
chown -R root .
chown -R mysql data
\rm -rf /etc/my.cnf
\ln -sf ${DEPLOY_HOME}/my.cnf-${HOSTNAME} /etc/my.cnf
\cp -f support-files/mysql.server /etc/init.d/mysql
chmod 755 /etc/init.d/mysql
chkconfig mysql on

echo "export PATH=\$PATH:${MYSQL_HOME}/bin" >> ~/.bashrc

/etc/init.d/mysql start

\rm -rf ${SRC_HOME}/${MYSQL_SRC}
