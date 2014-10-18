#!/bin/bash
LINUX_KITS=${WORK_KITS}/linux
echo LINUX_KITS=${LINUX_KITS}
if [ -d "${LINUX_KITS}" ] ; then
    PATH=${LINUX_KITS}/shell/bin:$PATH
    PATH=${LINUX_KITS}/android/bin:$PATH
    export PATH=$PATH
fi

