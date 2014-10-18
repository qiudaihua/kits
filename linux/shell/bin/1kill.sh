#!/bin/bash

KILL_KEY=$1

echo KILL_KEY=${KILL_KEY}

if [ -z "${KILL_KEY}" ]; then 
    KILL_KEY="system_"
fi

echo KILL_KEY=${KILL_KEY}

adb shell ps | grep "${KILL_KEY}" | cut -c 9-15 | xargs adb shell kill

