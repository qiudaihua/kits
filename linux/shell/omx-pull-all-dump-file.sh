#!/bin/sh
mkdir -p /work/file/temp/omx-dump/

adb wait-for-device

adb pull /data/dump_input.yuv /work/file/temp/dump/
adb pull /data/dump_output.264 /work/file/temp/dump/dump_output.264.avi
adb pull /data/inputbuffers.bin /work/file/temp/dump/
adb pull /data/media/yuvframes.yuv /work/file/temp/dump/

adb shell rm /data/dump_input.yuv  
adb shell rm /data/dump_output.264 
adb shell rm /data/inputbuffers.bin 
adb shell rm /data/slice_buffer*
adb shell rm /data/media/yuvframes.yuv
 
