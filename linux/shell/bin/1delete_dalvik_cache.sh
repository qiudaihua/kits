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

delete_dalvik_cache_(){
    local APK_NAME=$1
    #echo APK_NAME=${APK_NAME}
    local CACHE_PATH="/data/dalvik-cache"
    ext=${1##*.}
    name=${1%.*}
    source 0echo_color.sh -b "delete_dalvik_cache_: $1"
    if [ "$1" == "framework-res.apk" ];then
        adb shell rm /system/framework/$1
    elif [ "$ext" == "jar" ];then
        adb shell rm /system/framework/$name.odex /system/framework/
        adb shell rm /data/dalvik-cache/system@framework@$name.jar@classes.dex
    elif [ "$ext" == "apk" ];then
        adb shell rm /data/dalvik-cache/system@app@$name.apk@classes.dex
        adb shell rm /system/app/$name.odex
        adb shell rm /system/priv-app/$name.odex
    fi
}

source 1ensure_root_rw.sh

delete_dalvik_cache_ $1

