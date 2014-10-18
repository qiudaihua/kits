#!/bin/sh
adb wait-for-device
adb logcat -v time > ./log_all.log
