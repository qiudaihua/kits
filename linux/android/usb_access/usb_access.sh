#!/bin/bash

function usb_access(){
    sudo ln -s /work/kits/linux/android/usb_access/51-android.rules /etc/udev/rules.d/51-android.rules
    sudo restart udev
    adb kill-server
    adb start-server
}

usb_access $*
