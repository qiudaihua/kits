#!/bin/sh

echo startup >> /work/debug.log
echo ${DAIQ_WORK_HOME} >> /work/debug.log

DAIQ_STARTUP_DIR=${DAIQ_WORK_HOME}/etc/startup

if [ -d "${DAIQ_STARTUP_DIR}" ] ; then
    DAIQ_STARTUP_SHELL_LIST=`ls ${DAIQ_STARTUP_DIR}/*.sh`
    if [ $? -eq 0 ]; then
        for DAIQ_STARTUP_SHELL in ${DAIQ_STARTUP_SHELL_LIST}
        do
            echo DAIQ_STARTUP_SHELL=${DAIQ_STARTUP_SHELL} >> /work/debug.log
            ${DAIQ_STARTUP_SHELL}
        done
    fi
    info=`ls ${DAIQ_STARTUP_DIR}/*.sh`
    echo info=$info >> /work/debug.log
fi

