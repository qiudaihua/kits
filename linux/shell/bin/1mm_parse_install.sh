#!/bin/bash

parse_mm_install(){
    local MM_PATH=$1
    local IS_SLIENT=false
    local IS_RE_BUILD=false
    shift
    for i in "$@"; do
        case $i in
            -B | --rebuild)
                IS_RE_BUILD=true
	            ;;
            -S | --slient)
                IS_SLIENT=true
	            ;;
        esac
    done

    #echo MM_PATH=${MM_PATH}
    #echo IS_SLIENT=${IS_SLIENT}
    #echo IS_RE_BUILD=${IS_RE_BUILD}
    
    ARG_SLIENT=""
    if [ ${IS_SLIENT} == true ]; then
        ARG_SLIENT=" -s " #-s, --silent, --quiet
    fi
    #echo ARG_SLIENT=${ARG_SLIENT}

    ARG_RE_BUILD=""
    if [ ${IS_RE_BUILD} == true ]; then
        ARG_RE_BUILD=" -B "
    fi
    #echo ARG_RE_BUILD=${ARG_RE_BUILD}

    if [ ! -d "${MM_PATH}" ]; then
        source 0echo_color.sh -r "!!! MM_PATH is no exist !!!"
        #exit 0;
    else
        local mm_type=`type -t mm`
        if [ "function" != "${mm_type}" ];then
            source build/envsetup.sh
        fi
        cd ${MM_PATH}
        INSTALL_PREFIX="Install: "
        MM_INSTALL_LIST=` mm ${ARG_RE_BUILD} ${ARG_SLIENT} | grep "${INSTALL_PREFIX}" `
        #array_num=${#MM_INSTALL_LIST[@]}
        if [ -z "${MM_INSTALL_LIST}" ]; then
            source 0echo_color.sh -r "!!! MM_INSTALL_LIST is null !!!"
            #exit 0;
        else
            MM_INSTALL_LIST=${MM_INSTALL_LIST//"${INSTALL_PREFIX}"/""}
            source 0echo_color.sh -b "MM_INSTALL_LIST:"
            for MM_INSTALL in ${MM_INSTALL_LIST}
            do
                source 0echo_color.sh -b "\t${MM_INSTALL}"
            done
        fi
        cd -
    fi
}

parse_mm_install $*



