#!/bin/bash

search_out_install(){
    local PRODUCT_NAME=$1
    local OUT_PATH="out/target/product/${PRODUCT_NAME}"
    shift
    local TARGET_LIST=$*
    #echo TARGET_LIST=${TARGET_LIST}
    
    if [ -z "${TARGET_LIST}" ]; then
        source 0echo_color.sh -r "!!! TARGET_LIST is null !!!"
    else
        croot
        croot_ret=$?
        SEARCH_LIST=""
        for TARGET in ${TARGET_LIST}
        do
            RET_LIST=`find "${OUT_PATH}" -name "${TARGET}*" \
                        ! -path "${OUT_PATH}/obj*" \
                        ! -path "${OUT_PATH}/symbols*" `
            if [ ! -z "${RET_LIST}" ]; then
                for RET in ${RET_LIST}
                do
                    SEARCH_LIST="${SEARCH_LIST} ${RET}"
                done
            fi
        done
        
        source 0echo_color.sh -b "SEARCH_LIST:"
        for SEARCH in ${SEARCH_LIST}
        do
            source 0echo_color.sh -b "\t${SEARCH}"
        done
        if [ $croot_ret -eq 0 ]; then
            cd -
        fi
    fi
}

search_out_install $*



