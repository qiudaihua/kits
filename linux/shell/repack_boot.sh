#cp device/qcom/msm8226/init.target.rc $OUT/root/
#cp device/qcom/common/rootdir/etc/init.qcom.rc $OUT/root/
#cp device/qcom/msm8226/fstab.qcom $OUT/root/
echo "#" > $OUT/root/default.prop; \
	        echo "# ADDITIONAL_DEFAULT_PROPERTIES" >> $OUT/root/default.prop; \
	        echo "#" >> $OUT/root/default.prop;
echo "ro.secure=0" >> $OUT/root/default.prop;  echo "ro.allow.mock.location=0" >> $OUT/root/default.prop;  echo "ro.debuggable=1" >> $OUT/root/default.prop;  echo "persist.sys.strict_op_enable=false" >> $OUT/root/default.prop;  echo "persist.sys.whitelist=/system/etc/whitelist_appops.xml" >> $OUT/root/default.prop;  echo "ro.config.alarm_alert=alarm1.mp3" >> $OUT/root/default.prop;  echo "ro.config.ringtone=Whisper_of_Water.mp3" >> $OUT/root/default.prop;  echo "ro.config.notification_sound=message2.mp3" >> $OUT/root/default.prop;
build/tools/post_process_props.py $OUT/root/default.prop
out/host/linux-x86/bin/mkbootfs $OUT/root | out/host/linux-x86/bin/minigzip > $OUT/ramdisk.img
out/host/linux-x86/bin/dtbTool -o $OUT/dt.img -s 2048 -p $OUT/obj/KERNEL_OBJ/scripts/dtc/ $OUT/obj/KERNEL_OBJ/arch/arm/boot/

chmod a+r $OUT/dt.img
out/host/linux-x86/bin/mkbootimg  --kernel $OUT/kernel --ramdisk $OUT/ramdisk.img --cmdline "androidboot.hardware=qcom androidboot.oem.product=S399 user_debug=31 msm_rtb.filter=0x37" --base 0x00000000 --pagesize 2048 --ramdisk_offset 0x02000000 --tags_offset 0x01E00000 --dt $OUT/dt.img  --output $OUT/boot.img
size=$(for i in $OUT/boot.img; do stat --format "%s" "$i" | tr -d '\n'; echo +; done; echo 0); total=$(( $( echo "$size" ) )); printname=$(echo -n "$OUT/boot.img" | tr " " +); img_blocksize=135168; if [ "" == "yaffs" ]; then reservedblocks=8; else reservedblocks=0; fi; twoblocks=$((img_blocksize * 2)); onepct=$(((((17301504 / 100) - 1) / img_blocksize + 1) * img_blocksize)); reserve=$(((twoblocks > onepct ? twoblocks : onepct) + reservedblocks * img_blocksize)); maxsize=$((17301504 - reserve)); echo "$printname maxsize=$maxsize blocksize=$img_blocksize total=$total reserve=$reserve"; if [ "$total" -gt "$maxsize" ]; then echo "error: $printname too large ($total > [17301504 - $reserve])"; false; elif [ "$total" -gt $((maxsize - 32768)) ]; then echo "WARNING: $printname approaching size limit ($total now; limit $maxsize)"; fi 
$OUT/boot.img maxsize=17031168 blocksize=135168 total=7194624 reserve=270336

adb reboot bootloader

sleep 2

fastboot flash boot $OUT/boot.img
fastboot reboot
#. myflash.sh boot reboot
