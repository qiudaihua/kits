#!/bin/bash
echo "waiting for device..."
adb wait-for-device
result=`adb shell id|grep "uid=0(root) gid=0(root)" `
if [ "$result" == "" ] ;then
    echo "need root"
    adb root gosomo.cn
    adb wait-for-device
fi

result=`adb shell mount |grep "/system ext4 rw"`

if [ "$result" == "" ];then
    echo "need remount"
    adb remount
    adb wait-for-device
fi
