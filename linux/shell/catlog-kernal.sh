#!/bin/sh
adb wait-for-device
adb shell dmesg  > ./log_kernal.log
