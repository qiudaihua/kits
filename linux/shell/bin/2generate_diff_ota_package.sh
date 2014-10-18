#!/bin/bash

function generate_diff_ota_package(){
    LAST_OTA_FILE=$1
    CURRENT_OTA_FILE=$2
    DIFF_OTA_FILE=$3
    
    DIFF_OTA_SHELL="./build/tools/releasetools/ota_from_target_files \
        -x pagesize=4096 \
        -k ./build/target/product/security/releasekey \
        -d MMC -v -i \
        ${LAST_OTA_FILE} ${CURRENT_OTA_FILE} \
        ${DIFF_OTA_FILE}
        #S399-V17B-V20B-update-diff.zip "
    croot
    source 0echo_color.sh -g "${DIFF_OTA_SHELL}"
    "${DIFF_OTA_SHELL}"
    cd -
}

source 1setup_android_env.sh
generate_diff_ota_package $*

