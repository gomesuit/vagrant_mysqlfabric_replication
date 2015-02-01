#!/bin/sh
echo "alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'" >> /home/vagrant/.bashrc
\cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# init vagrant
/vagrant/provision/install/init_vagrant.sh

. /etc/global.rc

# yum install
${SCRIPT_HOME}/install_yum.sh

# service stop
${SCRIPT_HOME}/stop_service.sh

# install mysql
${SCRIPT_HOME}/install_mysql-5.6.22.sh

# setting mysql fabric
cat ${SCRIPT_HOME}/sql_setup_fabric-${HOSTNAME}.sql | mysql -uroot
