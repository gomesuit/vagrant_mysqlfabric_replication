#!/bin/sh

VAGRANT_HOME="/vagrant"
VAGRANT_PROVISION="${VAGRANT_HOME}/provision"
VAGRANT_INSTALL="${VAGRANT_PROVISION}/install"
VAGRANT_DEPLOY="${VAGRANT_PROVISION}/deploy"
VAGRANT_SRC="${VAGRANT_PROVISION}/src"

. ${VAGRANT_INSTALL}/global.rc

cd /

mkdir -p ${SCRIPT_HOME}
mkdir -p ${DEPLOY_HOME}
mkdir -p ${SRC_HOME}

rsync -ruv --delete ${VAGRANT_INSTALL}/ ${SCRIPT_HOME}/
rsync -ruv --delete ${VAGRANT_DEPLOY}/ ${DEPLOY_HOME}/
rsync -ruv --delete ${VAGRANT_SRC}/ ${SRC_HOME}/

ln -sf ${SCRIPT_HOME}/global.rc /etc/global.rc
