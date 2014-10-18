#!/bin/bash

delete_dalvik_cache(){
    local APK_NAME=$1
    #echo APK_NAME=${APK_NAME}
    local CACHE_PATH="/data/dalvik-cache"
    local ls_shell="adb shell ls ${CACHE_PATH} | grep \"\@${APK_NAME}\""
    local DELETE_LIST=` ${ls_shell} `
    echo "adb shell ls ${CACHE_PATH} | grep \"${APK_NAME}\" "
    echo DELETE_LIST=${DELETE_LIST}
    
    
    if [ -z "${DELETE_LIST}" ]; then
        source 0echo_color.sh -r "!!! There is no dalvik cache !!!"
    elif [ "${DELETE_LIST}" != "${DELETE_LIST//"classes.dex"/""}" ]; then
        for CACHE in "${DELETE_LIST}"
        do
            echo CACHE=${CACHE};
            clear_shell="adb shell \" rm ${CACHE_PATH}/${CACHE}\"";
            #source 0echo_color.sh -b "${clear_shell}"
            #clear_shell=${clear_shell//"@"/"*"}
            echo clear_shell=${clear_shell};
            #${clear_shell};
            adb shell  rm "${CACHE_PATH}"/"${CACHE}" ;
        done
    fi
}


source 1ensure_root_rw.sh
delete_dalvik_cache $*

