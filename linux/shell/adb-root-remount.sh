#!/bin/sh
adb wait-for-device
adb root gosomo.cn
adb wait-for-device
adb remount
