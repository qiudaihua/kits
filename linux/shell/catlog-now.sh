#!/bin/sh
adb wait-for-device
adb logcat -c
adb logcat -v time > ~/local/file-temp/log/log_now.log
