#!/bin/bash

function parse_androidmanifest(){
    local MK_PATH=$1
    AM_FILE=`find ${MK_PATH} -maxdepth 1 -name "AndroidManifest.xml" `
    echo AM_FILE=${AM_FILE}
    if [ ! -d "${MK_PATH}" ] || [ -z "${AM_FILE}" ] ; then
        source 0echo_color.sh -r "There is no AndroidManifest.mk: ${MK_PATH}!!!"
        #exit 0;
    else
        PACKAGE_NAME_LIST=`cat ${AM_FILE} | grep " package=" `
        PACKAGE_NAME_LIST=${PACKAGE_NAME_LIST//" "/""}
        PACKAGE_NAME_LIST=${PACKAGE_NAME_LIST//"package="/""}
        if [ -z "${PACKAGE_NAME_LIST}" ]; then
            source 0echo_color.sh -r "There is no LOCAL_PACKAGE_NAME in Android.mk!!!"
            #exit 0;
        else
            source 0echo_color.sh -b "PACKAGE_NAME_LIST:"
            for PACKAGE_NAME in ${PACKAGE_NAME_LIST}
            do
                source 0echo_color.sh -b "\t${PACKAGE_NAME}"
            done
            sleep 0.5
        fi
    fi

    
}

parse_androidmanifest $*

