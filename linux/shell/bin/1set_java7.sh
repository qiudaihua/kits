#!/bin/bash

if [ ! "$JAVA7_HOME" ]; then
    echo "!!! JAVA7_HOME not set !!!"
    echo "Please set JAVA7_HOME with the openjdk-7-jdk installed path."
    exit 0;
fi

export CLASSPATH=`echo $CLASSPATH | sed s:$JAVA_HOME:$JAVA7_HOME:g`
export PATH=`echo $PATH | sed s:$JAVA_HOME:$JAVA7_HOME:g`
export JAVA_HOME=$JAVA7_HOME
export JRE_HOME=$JAVA_HOME/jre

