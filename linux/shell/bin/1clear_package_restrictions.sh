#!/bin/bash

clear_package_restrictions(){
    local SEARCH_LIST=`adb shell ls /data/system/users/*/package-restrictions*.xml | grep -v ".xml:" `
    #echo SEARCH_LIST=${SEARCH_LIST}
    
    if [ -z "${SEARCH_LIST}" ]; then
        source 0echo_color.sh -r "!!! There is no package-restrictions*.xml !!!"
    else
        for xml in ${SEARCH_LIST}
        do
            echo xml=${xml}
            clear_shell="adb shell rm ${xml}"
            source 0echo_color.sh -b "${clear_shell}"
            ${clear_shell};
        done
    fi
}

source 1ensure_root_rw.sh
clear_package_restrictions $*


