#!/bin/bash 
#. ./ensure_root_rw.sh
function mymmm()
{
    if [ "$1" != "reboot" ];then
	   echo "mmm $1"
	   mmm $1 
    fi
	case "$1" in
        "frameworks/base/core/res/")
        . ./push.sh framework-res.apk  
        ;;
        "frameworks/base/services/java/")
        . ./push.sh services.jar
        ;;
		"frameworks/base/policy/")
		. ./push.sh android.policy.jar
		;;
	    "frameworks/base/")
		. ./push.sh framework.jar
		;;
		"reboot")
			adb reboot
	    ;;
		*)
		. ./push.sh  `basename $1`.apk
		;;
	esac
}
#mymmm $1 $2
#return
while [ $# -ge 1 ] 
do
mymmm $1
shift
done

