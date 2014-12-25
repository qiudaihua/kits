#!/bin/bash

generate_diff_ota_package(){
    OLD_OTA_PACKAGE_FILE=$1
    NEW_OTA_PACKAGE_FILE=$2
    DIFF_OTA_PACKAGE_FILE_NAME=$3
    ./build/tools/releasetools/ota_from_target_files \
    -x pagesize=4096 \
    -k ./build/target/product/security/releasekey \
    -d MMC  -v -i \
    ${OLD_OTA_PACKAGE_FILE} \
    ${NEW_OTA_PACKAGE_FILE} \
    ${DIFF_OTA_PACKAGE_FILE_NAME}.zip
}

generate_diff_ota_package $*
#generate_diff_ota_package \
#  /file/release/S399/S399_MSM8926_1437_00_V20B_CN-2014-0915/image/android/unsigned-ota/S399-target_files-eng.builder.zip\
#  /file/release/S399/S399_MSM8926_1446_00_V21B_CN-2014-1110/image/android/unsigned-ota/S399-target_files-eng.builder.zip\
#  S399-V20B-V21B-update-diff
