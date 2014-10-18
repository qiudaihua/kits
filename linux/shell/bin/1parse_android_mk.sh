#!/bin/bash

function parse_android_mk(){
    local MK_PATH=$1
    MK_FILE=`find ${MK_PATH} -maxdepth 1 -name "Android.mk" `
    echo MK_FILE=${MK_FILE}
    if [ ! -d "${MK_PATH}" ] || [ -z "${MK_FILE}" ] ; then
        source 0echo_color.sh -r "There is no Android.mk: ${MK_PATH}!!!"
        #exit 0;
    else
        HAS_PACKAGE_MODULE=`cat ${MK_FILE} | grep "BUILD_PACKAGE" `
        MODULE_NAME_LIST=`cat ${MK_FILE} | grep "LOCAL_PACKAGE_NAME" `
        MODULE_NAME_LIST=${MODULE_NAME_LIST//" "/""}
        MODULE_NAME_LIST=${MODULE_NAME_LIST//"LOCAL_PACKAGE_NAME:="/""}
        if [ -z "${MODULE_NAME_LIST}" ]; then
            source 0echo_color.sh -r "There is no LOCAL_PACKAGE_NAME in Android.mk!!!"
            #exit 0;
        else
            source 0echo_color.sh -b "MODULE_NAME_LIST:"
            for PACKAGE_NAME in ${MODULE_NAME_LIST}
            do
                source 0echo_color.sh -b "\t${PACKAGE_NAME}"
            done
            sleep 0.5
        fi
    fi

    
}

parse_android_mk $*

