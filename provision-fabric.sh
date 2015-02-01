#!/bin/sh
echo "alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'" >> /home/vagrant/.bashrc

# init vagrant
/vagrant/provision/install/init_vagrant.sh

. /etc/global.rc

\cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# yum install
${SCRIPT_HOME}/install_yum.sh

# service stop
${SCRIPT_HOME}/stop_service.sh

# install mysql
${SCRIPT_HOME}/install_mysql-5.6.22.sh

# install mysql-utilities
${SCRIPT_HOME}/install_mysql-utilities-1.5.3.sh

# setting mysql fabric
mysqlfabric group create fabric_test
mysqlfabric group add fabric_test 192.168.33.20:3306
mysqlfabric group add fabric_test 192.168.33.30:3306
mysqlfabric group promote fabric_test
mysqlfabric group activate fabric_test

# sample program
yum -y install ant gjava-1.7.0-openjdk java-1.7.0-openjdk-devel

cd ${SRC_HOME}
wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.34.tar.gz
tar zxf mysql-connector-java-5.1.34.tar.gz
cd mysql-connector-java-5.1.34
\cp -f mysql-connector-java-5.1.34-bin.jar /vagrant/sample/lib/
\rm -rf ${SRC_HOME}/mysql-connector-java-5.1.34
