#!/bin/bash

# Utility script to start Titanium Mobile project from the command line.
# More info at http://github.com/guilhermechapiewski/titanium-jasmine

PROJECT_NAME=${PROJECT_NAME}
PROJECT_ROOT=${PROJECT_ROOT:-../}
APP_DEVICE=${DEVICE_TYPE}
IPHONE_SDK_VERSION="4.2"
TI_SDK_VERSION="1.6.1"
TI_DIR="/Library/Application\ Support/Titanium"
TI_ASSETS_DIR="${TI_DIR}/mobilesdk/osx/${TI_SDK_VERSION}"
TI_IPHONE_DIR="${TI_ASSETS_DIR}/iphone"
TI_BUILD="${TI_IPHONE_DIR}/builder.py"

if [ "PROJECT_NAME" == "" ]; then
	echo "[ERROR] Please inform PROJECT_NAME."
	exit 1
fi

if [ "DEVICE_TYPE" == "" ]; then
	echo "[ERROR] Please inform DEVICE_TYPE ('ipad' or 'iphone')."
	exit 1
fi

# Get APP parameters from current tiapp.xml
APP_ID=`cat ${PROJECT_NAME}/tiapp.xml | grep "<id>" | sed -e "s/<\/*id>//g"`
APP_NAME=`cat ${PROJECT_NAME}/tiapp.xml | grep "<name>" | sed -e "s/<\/*name>//g"`

if [ "APP_ID" == "" ] || [ "APP_NAME" == "" ]; then
	echo "[ERROR] Could not obtain APP parameters from tiapp.xml file (does the file exist?)."
	exit 1
fi

bash -c "${TI_BUILD} run ${PROJECT_ROOT}/${PROJECT_NAME}/ ${IPHONE_SDK_VERSION} ${APP_ID} ${APP_NAME} ${APP_DEVICE}" \
	| perl -pe 's/^\[DEBUG\].*$/\e[35m$&\e[0m/g;s/^\[INFO\].*$/\e[36m$&\e[0m/g;s/^\[WARN\].*$/\e[33m$&\e[0m/g;s/^\[ERROR\].*$/\e[31m$&\e[0m/g;'

killall "iPhone Simulator"