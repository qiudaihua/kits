#!/bin/bash

function bk_android_jar()
{
    local JAVA_LIBRARIES_PATH="out/target/common/obj/JAVA_LIBRARIES"
    local dir_postfix="_intermediates"
    local class_jar="classes-jarjar.jar"
    local cp_dir="../droid_jars"

    croot
    croot_ret=$?

    if [ -d ${JAVA_LIBRARIES_PATH} ]; then
        rm -rf ${cp_dir}
        mkdir ${cp_dir}
        SEARCH_LIST=`find "${JAVA_LIBRARIES_PATH}" -name "*${dir_postfix}"`
        if [ ! -z "${SEARCH_LIST}" ]; then
            for ONE_RET in ${SEARCH_LIST}
            do
                jar_file=${ONE_RET}/${class_jar}
                if [ -f "${jar_file}" ]; then
                    jar_name="${ONE_RET//"${JAVA_LIBRARIES_PATH}/"/""}"
                    jar_name="${jar_name//"${dir_postfix}"/".jar"}"
                    echo "backup --> ${jar_name}"
                    cp ${jar_file} ${cp_dir}/${jar_name}
                fi 
            done
        fi
    fi

    if [ $croot_ret -eq 0 ]; then
            cd -
    fi
}

#source 1setup_android_env.sh

bk_android_jar $*


