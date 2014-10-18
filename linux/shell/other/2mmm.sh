#!/bin/bash

set -x
FILE_TYPE="apk"
FILE_ODEX="odex"
IN_DIR="packages/apps"
MMM_TARGET=$1
OUT_DIR="out/target/product/$TARGET_PRODUCT"
PUSH_DIR="system/app"
IS_DIR_ARG=false
MMM_TARGET=$1
MMM_ARG=""
MMM_FLAG=true
if [ -z "$1" ];then
    return;
else
if [ "$2" != "${2##*-}" ];then
    MMM_ARG="$2"
elif [ -n "$2" ];then
    MMM_FLAG=false
fi
fi

if [ "$MMM_TARGET" != "${MMM_TARGET##*/}" ];then
IS_DIR_ARG=true
if [ "$1" == "frameworks/base" ] || [ "$1" == "frameworks/base/" ];then
    IN_DIR="frameworks/base"
    MMM_TARGET="frameworks"
    PUSH_DIR="system/framework"
else
if [ "${MMM_TARGET##*/}" == "" ];then
    MMM_TARGET=${MMM_TARGET%/}
fi
    IN_DIR=${MMM_TARGET%/*}
    MMM_TARGET=${MMM_TARGET##*/}
fi
else
if [ "$MMM_TARGET" == "api" ] ;then
    IN_DIR="frameworks/base"
    MMM_TARGET="api"
    PUSH_DIR="system/framework"
elif [ "$MMM_TARGET" == "framework" ];then
    IN_DIR="frameworks/base"
    MMM_TARGET="frameworks"
    PUSH_DIR="system/framework"
elif [ "$MMM_TARGET" == "SystemUI" ] || [ "$MMM_TARGET" == "SettingsProvider" ];then
    IN_DIR="frameworks/base/packages"
elif [ "$MMM_TARGET" == "*Provider" ];then
    IN_DIR="packages/providers"
fi
fi

echo "TARGET_PRODUCT = $TARGET_PRODUCT"
echo "IS_DIR_ARG = $IS_DIR_ARG"
echo "MMM_TARGET = $MMM_TARGET"
echo "MMM_ARG = $MMM_ARG"
echo "MMM_FLAG = $MMM_FLAG"
echo "IN_DIR = $IN_DIR"
echo "OUT_DIR = $OUT_DIR"
echo "PUSH_DIR = $PUSH_DIR"

set -x
if [ $MMM_TARGET == "frameworks" ];then

if [ $MMM_FLAG == true ];then
if false; then
mmm frameworks/base $MMM_ARG
mmm frameworks/base/core/res $MMM_ARG
mmm frameworks/base/services/java $MMM_ARG
mmm frameworks/base/policy $MMM_ARG
else
make update-api
fi
fi

if false ;then
adb push $OUT_DIR/$PUSH_DIR/framework.odex /$PUSH_DIR
adb push $OUT_DIR/$PUSH_DIR/framework.jar /$PUSH_DIR
adb push $OUT_DIR/$PUSH_DIR/ext.odex /$PUSH_DIR
adb push $OUT_DIR/$PUSH_DIR/ext.jar /$PUSH_DIR
adb push $OUT_DIR/$PUSH_DIR/framework_ext.odex /$PUSH_DIR
adb push $OUT_DIR/$PUSH_DIR/framework_ext.jar /$PUSH_DIR

adb push $OUT_DIR/$PUSH_DIR/services.odex /$PUSH_DIR
adb push $OUT_DIR/$PUSH_DIR/services.jar /$PUSH_DIR
adb push $OUT_DIR/$PUSH_DIR/android.policy.odex /$PUSH_DIR
adb push $OUT_DIR/$PUSH_DIR/android.policy.jar /$PUSH_DIR
else
adb push $OUT_DIR/$PUSH_DIR /$PUSH_DIR
fi

else

if [ $MMM_FLAG == true ];then
mmm $IN_DIR/$MMM_TARGET $MMM_ARG
fi
adb push $OUT_DIR/$PUSH_DIR/$MMM_TARGET.$FILE_ODEX /$PUSH_DIR
adb push $OUT_DIR/$PUSH_DIR/$MMM_TARGET.$FILE_TYPE /$PUSH_DIR

fi

set +x
date "+%Y-%m-%d %H:%M:%S"

