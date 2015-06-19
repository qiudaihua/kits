REM echo get root perrmission
adb wait-for-device

echo create local log dir

mkdir log
mkdir log\dropbox
mkdir log\anr
mkdir log\tombstones
mkdir log\logcat
mkdir log\kernel

adb wait-for-device

echo get logcat log
start /b adb shell logcat -b radio -v time > log\logcat\radio.log
start /b adb shell logcat -b system -v time > log\logcat\system.log
start /b adb shell logcat -b main -v time > log\logcat\main.log
start /b adb shell logcat -b events -v time > log\logcat\events.log

echo get dumplog
adb shell dumpsys > log\dumpsys.txt

echo press any key or enter key stop monkey test and get log
pause

echo get test log 
REM get dropbox log /data/system/dropbox
adb pull /data/system/dropbox log\dropbox 
REM get anr log /data/anr
adb pull /data/anr log\anr 
REM get tombstones log /data/tombstones
adb pull /data/tombstones log\tombstones
adb shell dumpsys > log\dumpsysTestover.txt


