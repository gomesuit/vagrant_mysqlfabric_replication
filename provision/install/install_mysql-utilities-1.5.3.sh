#!/bin/sh

. /etc/global.rc

\rm -rf ${MYSQL_UTILITIES_HOME}
\rm -rf ${SRC_HOME}/${MYSQL_UTILITIES_SRC}

cd ${SRC_HOME}
wget http://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-utilities-1.5.3.tar.gz
tar zxf ${MYSQL_UTILITIES_SRC}.tar.gz
cd ${MYSQL_UTILITIES_SRC}
python ./setup.py build --build-base ${MYSQL_UTILITIES_HOME}
python ./setup.py install
\rm -rf /etc/mysql/fabric.cfg
\ln -sf ${DEPLOY_HOME}/fabric.cfg-${HOSTNAME} /etc/mysql/fabric.cfg

echo "export PATH=\$PATH:${MYSQL_UTILITIES_HOME}/scripts-2.6" >> ~/.bashrc

cat ${SCRIPT_HOME}/sql_setup_fabric-${HOSTNAME}.sql | mysql -uroot
mysqlfabric manage setup
mysqlfabric manage start --daemonize

\rm -rf ${SRC_HOME}/${MYSQL_UTILITIES_SRC}
