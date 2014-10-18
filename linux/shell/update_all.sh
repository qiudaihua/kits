#!/bin/bash

AP=$OUT
MP=

adb wait-for-device

adb reboot bootloader

fastboot flash partition ${MP}/gpt_both0.bin

fastboot flash ${MP} ${MP}/NON-HLOS.bin

fastboot flash sbl1 ${MP}/sbl1.mbn

fastboot flash rpm  ${MP}/rpm.mbn

fastboot flash tz   ${MP}/tz.mbn

fastboot flash splash ${AP}/splash.img

fastboot flash aboot ${AP}/emmc_appsboot.mbn

fastboot flash boot  ${AP}/boot.img

fastboot flash system ${AP}/system.img

fastboot flash userdata ${AP}/userdata.img

fastboot flash persist ${AP}/persist.img

fastboot flash cache   ${AP}/cache.img

fastboot flash recovery ${AP}/recovery.img

fastboot flash usbmsc ${AP}/usbdisk.img

fastboot reboot

