#!/bin/sh
adb wait-for-device
adb root gosomo.cn
sleep 1s
adb wait-for-device
adb remount
adb shell chmod 777 /data
adb shell chmod 777 /data/*
