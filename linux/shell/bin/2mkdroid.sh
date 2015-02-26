#!/bin/bash

MK_PATH="$1"
IS_NO_BUILD=false
IS_RE_BUILD=false
IS_SLIENT=false
IS_PUSH="auto"
IS_PUSH_TEST=false
IS_DELETE_DALVIK_CACHE=false
IS_KILL_SYSTEM=false
IS_REBOOT=false

shift
for i in "$@"; do
    case $i in
        -b | --no-build)
            IS_NO_BUILD=true
	        ;;
        -B | --rebuild)
            IS_RE_BUILD=true
	        ;;
        -S | --slient)
            IS_SLIENT=true
	        ;;
        -p | --no-push)
            IS_PUSH="false"
	        ;;
        -P | --push)
            IS_PUSH="true"
	        ;;
        -t | --no-push-tests)
            IS_PUSH_TEST=false
	        ;;
        -T | --push-tests)
            IS_PUSH_TEST=true
	        ;;
        -D | --delete-dalvik-cache)
            IS_DELETE_DALVIK_CACHE=true
            ;;
        -K | --kill-system)
            IS_KILL_SYSTEM=true
	        ;;
        -R | --reboot)
            IS_REBOOT=true
	        ;;
    esac
done

if [ ! -d "$MK_PATH" ] && [ ! -f "$MK_PATH" ]; then
    echo "!!! MK_PATH is no exist !!!"
    #exit 0;
elif [ -f "$MK_PATH" ];then
    MK_PATH=`dirname ${MK_PATH}`
fi

clear
source 0echo_color.sh -g "================>"
source 0echo_color.sh -r  `date "+%Y-%m-%d %H:%M:%S"`
source 0echo_color.sh -b "MK_PATH=${MK_PATH}"
source 0echo_color.sh -b "IS_NO_BUILD=${IS_NO_BUILD}"
source 0echo_color.sh -b "IS_SLIENT=${IS_SLIENT}"
source 0echo_color.sh -b "IS_RE_BUILD=${IS_RE_BUILD}"
source 0echo_color.sh -b "IS_PUSH=${IS_PUSH}"
source 0echo_color.sh -b "IS_PUSH_TEST=${IS_PUSH_TEST}"
source 0echo_color.sh -b "IS_DELETE_DALVIK_CACHE=${IS_DELETE_DALVIK_CACHE}"
source 0echo_color.sh -b "IS_KILL_SYSTEM=${IS_KILL_SYSTEM}"
source 0echo_color.sh -b "IS_REBOOT=${IS_REBOOT}"

sleep 1

source 1setup_android_env.sh

source 1parse_android_mk.sh ${MK_PATH}

MM_ARG=""
if [ ${IS_SLIENT} == true ]; then
    MM_ARG=" -S ${MM_ARG} "
fi
if [ ${IS_RE_BUILD} == true ]; then
    MM_ARG=" -B ${MM_ARG} "
fi

MM_INSTALL_LIST=""
if [ ${IS_NO_BUILD} == false ]; then
    source 1mm_parse_install.sh ${MK_PATH} ${MM_ARG}
fi

PUSH_ARG=""
if [ ${IS_PUSH_TEST} == true ]; then
    PUSH_ARG=" -T ${PUSH_ARG} "
fi
if [ ${IS_DELETE_DALVIK_CACHE} == true ]; then
    PUSH_ARG=" -D ${PUSH_ARG} "
fi

if [ "${IS_PUSH}" == "auto" ] || [ "${IS_PUSH}" == "true" ]; then
    if [ ! -z "${MM_INSTALL_LIST}" ]; then
        source 1ensure_root_rw.sh
        source 1push_install.sh ${PUSH_ARG} ${TARGET_PRODUCT} ${MM_INSTALL_LIST} 
    else
        source 0echo_color.sh -r "!!! MM_INSTALL_LIST is null !!!"
        if [ "${IS_PUSH}" == "true" ]; then
            source 1search_out_install.sh ${TARGET_PRODUCT} ${MODULE_NAME_LIST}
            if [ ! -z "${SEARCH_LIST}" ]; then
                source 1ensure_root_rw.sh
                source 1push_install.sh ${PUSH_ARG} ${TARGET_PRODUCT} ${SEARCH_LIST} 
            else
                source 0echo_color.sh -r "Nothing to push !!!"
            fi
        fi
    fi
fi

if [ ${IS_KILL_SYSTEM} == true ]; then
    source 1kill.sh "system_"
elif [ ${IS_REBOOT} == true ]; then
    adb reboot
fi


source 0echo_color.sh -r  `date "+%Y-%m-%d %H:%M:%S"`

