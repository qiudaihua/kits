#!/bin/bash
echo "waiting device..."
adb wait-for-device
echo "catching all log..."
adb logcat -v time -b main -b system -b events -b radio > ~/local/file-temp/log/log_all.log
