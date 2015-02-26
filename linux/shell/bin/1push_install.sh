#!/bin/bash

push_install(){
    local PUSH_ARG=""
    local IS_PUSH_TESTS=false
    local IS_DELETE_DALVIK_CACHE=false
    for i in "$@"; do
        case $i in
            -T | --push-tests)
                IS_PUSH_TESTS=true
	            ;;
            -D | --clear-dalvik-cache)
                IS_DELETE_DALVIK_CACHE=true
	            ;;
            *)
                break
	            ;;
        esac
        shift
    done
    local PRODUCT_NAME=$1
    local OUT_PATH="out/target/product/${PRODUCT_NAME}"
    shift
    local PUSH_LIST=$*
    
    #echo PRODUCT_NAME=${PRODUCT_NAME}
    #echo PUSH_LIST=${PUSH_LIST}
    #echo OUT_PATH=${OUT_PATH}
    #echo IS_PUSH_TESTS=${IS_PUSH_TESTS}
    
    croot
    croot_ret=$?
    local TESTS_SUBSTR="Tests"
    if [ -z "${PUSH_LIST}" ]; then
        source 0echo_color.sh -r "!!! PUSH_LIST is null !!!"
        if [ $croot_ret -eq 0 ]; then
            cd -
        fi
        #exit 0;
    elif [ -z "${OUT_PATH}" ] || [ ! -d "${OUT_PATH}" ]; then
        source 0echo_color.sh -r "!!! OUT_PATH is null !!!"
        if [ $croot_ret -eq 0 ]; then
            cd -
        fi
        #exit 0;
    else
        for ONE_INSTALL in ${PUSH_LIST}; do
            #echo ONE_INSTALL=${ONE_INSTALL}
            is_tests=""
            if [ ${IS_PUSH_TESTS} == false ]; then
                is_tests=` echo "${ONE_INSTALL}" | grep "${TESTS_SUBSTR}" `
            fi
            #echo is_tests=${is_tests}
            if [ "" == "${is_tests}" ]; then
                TARGET_DIR=${ONE_INSTALL//"${OUT_PATH}"/""}
                #echo TARGET_DIR=${TARGET_DIR}
                
                INSTALL_NAME=${TARGET_DIR##*/}
                #echo INSTALL_NAME=${INSTALL_NAME}
                if [ ${IS_DELETE_DALVIK_CACHE} == true ]; then
                    source 1delete_dalvik_cache.sh ${INSTALL_NAME}
                fi
                
                adb_push="adb push ${ONE_INSTALL} ${TARGET_DIR}"
                source 0echo_color.sh -g "${adb_push}"
                ${adb_push};
                adb shell sync
                
                if [ "${TARGET_DIR}" != "${TARGET_DIR//"/bin/"/""}" ]; then
                    adb_chmod="adb shell chmod 755 ${TARGET_DIR}"
                    source 0echo_color.sh -g "${adb_chmod}"
                    ${adb_chmod};
                fi
            fi
        done
        if [ $croot_ret -eq 0 ]; then
            cd -
        fi
    fi
}

push_install ${*}


