#!/bin/bash

adb shell ps | grep "system_" | cut -c 9-15 | xargs adb shell kill

