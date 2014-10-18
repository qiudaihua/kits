#!/bin/bash
if ! [ "" == "$OUT" ];then
    PREFIX=$OUT
else
    PREFIX=~/work/qmss19-8x10/LINUX/android/out/target/product/AD682H
fi
if ! [ "" == "$MODEM_OUT" ];then
    MODEM_PREFIX=$MODEM_OUT
else
    MODEM_PREFIX=/home/xgm/work/qrd8625q-la-3-0_qmss_oem/modem_proc/build/ms/bin/CALA04
fi
echo "flashing images in $PREFIX"
function flash_modem()
{
    fastboot oem okstart
    fastboot flash modem $MODEM_PREFIX/NON-HLOS.bin
    fastboot oem okstart
    fastboot flash sbl1 $MODEM_PREFIX/sbl1.mbn
    fastboot oem okstart
    fastboot flash rpm $MODEM_PREFIX/rpm.mbn
    fastboot oem okstart
    fastboot flash tz $MODEM_PREFIX/tz.mbn
}
function flash()
{
    if [ $1 == "aboot" ] ;then
        fastboot oem okstart
        fastboot flash $1 $PREFIX/emmc_appsboot.mbn
    elif [ $1 == "reboot" ] || [ $1 == "reboot-bootloader" ];then
        fastboot $1
    elif [ $1 == "android" ];then
        fastboot oem okstart
        fastboot oem disable-charger-screen
        flash aboot
        flash boot
        flash system
        flash recovery
        flash userdata
        flash splash
        flash cache
        flash persist
    elif [ $1 == "modem" ];then
        flash_modem
    elif [ $1 == "all" ];then
        flash modem
        flash android
    else
        fastboot oem okstart
        fastboot flash $1 $PREFIX/$1.img
    fi
}

while [ $# -ge 1 ] 
do 
flash $1
shift
done
