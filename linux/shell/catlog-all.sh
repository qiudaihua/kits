#!/bin/sh
adb wait-for-device
adb logcat -v time -b main -b system -b events -b radio > ~/local/file-temp/log/log_all.log
