#!/bin/bash

#echo profile_hook >> ${DAIQ_WORK_HOME}/debug.log

#echo DAIQ_WORK_HOME=${DAIQ_WORK_HOME} >> ${DAIQ_WORK_HOME}/debug.log
#echo DAIQ_JDK_VER=${DAIQ_JDK_VER} >> ${DAIQ_WORK_HOME}/debug.log

DAIQ_WORK_HOME=${DAIQ_WORK_HOME}
DAIQ_JDK_VER=${DAIQ_JDK_VER}

if [ -d "${DAIQ_WORK_HOME}" ] ; then
    DAIQ_LINUX_KITS=${DAIQ_WORK_HOME}/kits/linux

    DAIQ_SHELL_DIR=${DAIQ_LINUX_KITS}/shell
    DAIQ_ANDROID_DIR=${DAIQ_LINUX_KITS}/android

    DAIQ_LINUX_BIN=${DAIQ_LINUX_KITS}/bin
    DAIQ_LINUX_BIN=${DAIQ_LINUX_BIN}:${DAIQ_SHELL_DIR}/bin
    DAIQ_LINUX_BIN=${DAIQ_LINUX_BIN}:${DAIQ_ANDROID_DIR}/bin

    DAIQ_WORK_TOOL_DIR=${DAIQ_WORK_HOME}/tool
    #echo DAIQ_WORK_TOOL_DIR=${DAIQ_WORK_TOOL_DIR}

    #export java paths
    if [ -d "${DAIQ_WORK_TOOL_DIR}" ] ; then
        export JAVA6_HOME=`dirname ${DAIQ_WORK_TOOL_DIR}/java/jdk1.6*/bin`
        export JAVA7_HOME=/usr/lib/jvm/java-7-openjdk-amd64
        JAVA_HOME=`dirname ${DAIQ_WORK_TOOL_DIR}/java/jdk${DAIQ_JDK_VER}*/bin`
        if [ -z "${DAIQ_JDK_VER}" ] || [ ! -d "${JAVA_HOME}" ] ; then
            DAIQ_JDK_VER=1.6
            JAVA_HOME=`dirname ${DAIQ_WORK_TOOL_DIR}/java/jdk${DAIQ_JDK_VER}*/bin`
        fi
        if [ -d "${JAVA_HOME}" ] ; then
            export JAVA_HOME
            #echo JAVA_HOME=${JAVA_HOME}
            export JRE_HOME=${JAVA_HOME}/jre
            export CLASSPATH=.:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar
            #echo CLASSPATH=${CLASSPATH}
            DAIQ_LINUX_BIN=${JAVA_HOME}/bin:${DAIQ_LINUX_BIN}
        fi
    fi

    # export android home
    DAIQ_ANDROID_HOME=${DAIQ_WORK_HOME}/android/adt-bundle/sdk
    if [ -d "${DAIQ_ANDROID_HOME}" ]; then
        export ANDROID_HOME=${DAIQ_ANDROID_HOME}
        DAIQ_LINUX_BIN=${DAIQ_LINUX_BIN}:${ANDROID_HOME}/tools
    fi

    # export ant home
    if [ -d "${DAIQ_WORK_HOME}/tool/apache-ant/bin" ]; then
        export ANT_HOME=${DAIQ_WORK_HOME}/tool/apache-ant
        DAIQ_LINUX_BIN=${DAIQ_LINUX_BIN}:${ANT_HOME}/bin
    fi

    #export linux bin paths
    export PATH=${DAIQ_LINUX_BIN}:${PATH}
    #echo PATH=${PATH}s
    #java -version

fi

