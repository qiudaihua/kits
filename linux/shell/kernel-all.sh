#!/bin/sh
adb wait-for-device
adb shell dmesg > ./kernel_all.log &
