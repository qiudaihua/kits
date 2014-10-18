#!/bin/bash

function setup_android_env(){
    IS_RE_SET=false
    
    for i in "$@"; do
        case $i in
            -r | ---no-resetup)
                IS_RE_SET=false
	            ;;
            -R | --resetup)
                IS_RE_SET=true
	            ;;
        esac
    done

    #echo $PWD
    local env_file="build/envsetup.sh"
    local mm_type=`type -t mm`
    local current_path=$PWD
    if [ "function" != "${mm_type}" ];then
        if [ ! -f "${env_file}" ]; then
            local source_dir="${current_path%%/android/*}/android"
            echo ${source_dir}
            cd ${source_dir}
            if [  ! -f "${env_file}" ]; then
                source 0echo_color.sh -r "There is no ${env_file} !!!"
                return 0;
            fi
        fi
        source ${env_file} #1>&- 2>&- 
        cd ${current_path}
    fi

    if [ -z "$TARGET_PRODUCT" ];then
        source 0echo_color.sh -r "TARGET_PRODUCT is null !!!"
        lunch
    elif [ "${IS_RE_SET}" == true ]; then
        source 0echo_color.sh -b "OLD TARGET_PRODUCT is ${TARGET_PRODUCT}-${TARGET_BUILD_VARIANT}, now reset."
        lunch
    else
        source 0echo_color.sh -g "Android environment had set up, TARGET_PRODUCT=${TARGET_PRODUCT}-${TARGET_BUILD_VARIANT}."
    fi
}

setup_android_env $*

