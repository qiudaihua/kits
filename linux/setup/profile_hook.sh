#!/bin/bash

#echo DAIQ_WORK_HOME=${DAIQ_WORK_HOME}
#echo DAIQ_JDK_VERE=${DAIQ_JDK_VER}
LOCAL_WORK_HOME=${DAIQ_WORK_HOME}
LOCAL_JDK_VER=${DAIQ_JDK_VER}

if [ -d "${LOCAL_WORK_HOME}" ] ; then
    LOCAL_LINUX_KITS=${LOCAL_WORK_HOME}/kits/linux

    LOCAL_SHELL_DIR=${LOCAL_LINUX_KITS}/shell
    LOCAL_ANDROID_DIR=${LOCAL_LINUX_KITS}/android

    LOCAL_LINUX_BIN=${LOCAL_LINUX_KITS}/bin
    LOCAL_LINUX_BIN=${LOCAL_LINUX_BIN}:${LOCAL_SHELL_DIR}/bin
    LOCAL_LINUX_BIN=${LOCAL_LINUX_BIN}:${LOCAL_ANDROID_DIR}/bin

    LOCAL_WORK_TOOL_DIR=${LOCAL_WORK_HOME}/tool
    #echo LOCAL_WORK_TOOL_DIR=${LOCAL_WORK_TOOL_DIR}

    #export java paths
    if [ -d "${LOCAL_WORK_TOOL_DIR}" ] ; then
        if [ -z "${LOCAL_JDK_VER}" ] ; then 
            LOCAL_JDK_VER=1.6
        fi
        JAVA_HOME=`dirname ${LOCAL_WORK_TOOL_DIR}/java/jdk${LOCAL_JDK_VER}*/bin`
        if [ -d "${JAVA_HOME}" ] ; then
            export JAVA_HOME
            #echo JAVA_HOME=${JAVA_HOME}
            export CLASSPATH=.:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar
            #echo CLASSPATH=${CLASSPATH}
            LOCAL_LINUX_BIN=${JAVA_HOME}/bin:${LOCAL_LINUX_BIN}
        fi
    fi

    #export linux bin paths
    export PATH=${LOCAL_LINUX_BIN}:${PATH}
    #echo PATH=${PATH}s
    #java -version
fi

