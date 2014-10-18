#!/bin/bash 
. ./ensure_root_rw.sh
function mypush()
{
	echo "pushing $1"
	ext=${1##*.}
	name=${1%.*}
    if [ "$1" == "framework-res.apk" ];then
        adb push $OUT/system/framework/$1 /system/framework/
	elif [ "$ext" == "jar" ];then
		adb push $OUT/system/framework/$name.odex /system/framework/
		adb push $OUT/system/framework/$name.jar /system/framework/
	elif [ "$ext" == "apk" ];then
        adb shell rm /data/dalvik-cache/system@app@$name.apk@classes.dex
		adb push $OUT/system/app/$name.odex /system/app/
		adb push $OUT/system/app/$name.apk /system/app/
	elif [ "$ext" == "so" ];then
		adb push $OUT/system/lib/$name.so /system/lib/
	elif [ "$1" == "reboot" ];then
	    adb reboot
	else
		echo "invalid name $name"
		return 1
	fi
	return 0
}
while [ $# -ge 1 ] 
do
mypush $1
if [ $? -eq 1  ];then
return
fi
shift
done

