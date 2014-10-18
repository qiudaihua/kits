killall adb
adb wait-for-device
LAST_PID=
LOGCAT_PID=
PID=
while (true); do
PID=`adb shell ps |grep $1|awk '{if (NR==1)print $2}'`
if [ "$PID" == "" ];then
#echo "process not found"
sleep 1
continue
elif [ "$LAST_PID" == "$PID" ];then
#echo "pid the same:$LAST_PID"
sleep 1
continue
else
echo "pid changed from $LAST_PID to $PID"
LAST_PID=$PID
if [ "$LOGCAT_PID" != "" ];then
kill -9 $LOGCAT_PID
fi
killall grep
adb logcat -v time | grep --color=auto "${PID})" &
LOGCAT_PID=`ps aux |grep "adb logcat -v time" |awk '{if (NR==1)print $2}'`
fi
done
